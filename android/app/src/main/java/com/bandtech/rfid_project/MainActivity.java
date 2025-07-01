package com.bandtech.rfid_project;

import android.annotation.SuppressLint;
import android.media.AudioManager;
import android.media.ToneGenerator;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.pda.rfid.EPCModel;
import com.pda.rfid.IAsynchronousMessage;
import com.pda.rfid.uhf.UHF;
import com.pda.rfid.uhf.UHFReader;
import com.port.Adapt;
import com.util.Helper.Helper_ThreadPool;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

@SuppressLint("HandlerLeak")
public class MainActivity extends FlutterActivity implements IAsynchronousMessage {
    private static final String CHANNEL = "rfid_channel";
    private MethodChannel channel;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        channel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL);

        channel.setMethodCallHandler((call, result) -> {
            try {
                switch (call.method) {
                    case "getPower":
                        result.success(GetPower());
                        break;
                    case "setPower":
                        result.success(setPower(call.arguments == null ? _Max_Power : (int) call.arguments));
                        break;
                    case "init":
                        Init();
                        result.success(GetPower());
                        break;
                    case "dispose":
                        Dispose();
                        result.success(true);
                        break;
                    case "clear":
                        Clear();
                        result.success(true);
                        break;
                    case "readOrStop":
                        Read();
                        result.success(true);
                        break;
                    case "getStatus":
                        result.success(isRead);
                        break;
                    case "getData":
                        List<String> data = GetData();

                        result.success(data);
                        break;
                    case "setReadType":
                        if (call.arguments instanceof Integer) {
                            _ReadType = (Integer) call.arguments;
                            result.success(true);
                        } else {
                            result.error("INVALID_ARGUMENT", "Argument must be an integer", null);
                        }
                        break;
                    default:
                        result.notImplemented();
                        break;
                }
            } catch (Exception e) {
                result.error("ERROR", e.getMessage(), null);
            }
        });
    }


    public UHF CLReader = UHFReader.getUHFInstance();
    static Boolean _UHFSTATE = false;
    static int _NowAntennaNo = 1;
    static int _UpDataTime = 0;

    boolean isRead = false;

    private static boolean isStartPingPong = false;
    private boolean isKeyDown = false;
    private int keyDownCount = 0;
    private int _Max_Power = 30;

    private static int _ReadType = 0;
    private final HashMap<String, EPCModel> hmList = new HashMap<>();
    private final Object hmList_Lock = new Object();


    private static final boolean isPowerLowShow = false;

    private IAsynchronousMessage log = null;

    public void UHF_Dispose() {
        if (_UHFSTATE) {
            UHFReader._Config.CloseConnect();
            _UHFSTATE = false;
        }
    }

    @SuppressLint("UseSparseArrays")
    @SuppressWarnings("serial")
    protected void UHF_GetReaderProperty() {

        String propertyStr = UHFReader._Config.GetReaderProperty();

        String[] propertyArr = propertyStr.split("\\|");
        var hm_Power = new HashMap<Integer, Integer>() {
            {
                put(1, 1);
                put(2, 3);
                put(3, 7);
                put(4, 15);
            }
        };
        if (propertyArr.length > 3) {
            try {
                var x = hm_Power.get(Integer.parseInt(propertyArr[2]));
                if (x != null) _NowAntennaNo = x;
            } catch (Exception ex) {
                Log.d("Debug", "Get Reader Property failure and conversion failed!");
            }
        } else {
            Log.d("Debug", "Get Reader Property failure");
        }
    }

    public Boolean UHF_Init(IAsynchronousMessage log) {
        var rt = false;
        try {
            if (!_UHFSTATE) {
                boolean ret = UHFReader.getUHFInstance().OpenConnect(log);
                if (ret) {
                    rt = true;
                    _UHFSTATE = true;
                }

                Thread.sleep(500);
            } else {
                rt = true;
            }
        } catch (Exception ex) {
            Log.d("debug", "On the UHF electric abnormal:" + ex.getMessage());
        }
        return rt;
    }

    protected void UHF_SetTagUpdateParam() {


        var searchRT = UHFReader._Config.GetTagUpdateParam();
        var arrRT = searchRT.split("\\|");
        if (arrRT.length >= 2) {
            int nowUpDataTime = Integer.parseInt(arrRT[0]);
            Log.d("Debug", "Check the label to upload time:" + nowUpDataTime);
            if (_UpDataTime != nowUpDataTime) {

                UHFReader._Config.SetTagUpdateParam(_UpDataTime, 0);
                Log.d("Debug", "Sets the label upload time...");
            }
        } else {
            Log.d("Debug", "Query tags while uploading failure...");
        }
    }

    public int GetPower() {
        return UHFReader._Config.GetANTPowerParam();
    }

    public boolean setPower(int setParam) {

        int antCount = 1;

        if (_NowAntennaNo == 3) {
            antCount = 2;
        }
        int rt = UHFReader._Config.SetANTPowerParam(antCount, setParam);
        Log.d("RFID", "SetPower: " + rt);
        return rt == 0;
    }

    public void Read() {
        if (!isRead) {
            PingPong_Read();
            isRead = true;
        } else {
            Pingpong_Stop();
            isRead = false;
        }
    }


    public void Clear() {
        hmList.clear();
    }


    protected void Init() {
        log = this;
        if (!UHF_Init(log)) {

        } else {
            try {
                UHF_GetReaderProperty();
                Thread.sleep(20);
                CLReader.Stop();
                Thread.sleep(20);
                UHF_SetTagUpdateParam();
            } catch (Exception ignored) {
                Toast.makeText(this, "error" + ignored.getMessage(), Toast.LENGTH_SHORT).show();
            }

//            Refush();

        }
    }


//    protected void Refush() {
//        IsFlushList = true;
//
//        Helper_ThreadPool.ThreadPool_StartSingle(() -> {
//            while (IsFlushList) {
//                try {
//                    handler.sendMessage(handler.obtainMessage(MSG_RESULT_READ, null));
//                    Thread.sleep(1000);
//                } catch (InterruptedException ignored) {
//                }
//            }
//        });
//
//        Helper_ThreadPool.ThreadPool_StartSingle(() -> {
//            while (IsFlushList) {
//                synchronized (beep_Lock) {
//                    try {
//                        beep_Lock.wait();
//                    } catch (InterruptedException ignored) {
//                    }
//                }
//                if (IsFlushList) {
//                    toneGenerator.startTone(ToneGenerator.TONE_PROP_BEEP);
//                }
//
//            }
//        });
//    }


    protected void Dispose() {
        isStartPingPong = false;
        UHF_Dispose();
    }


    @SuppressWarnings({"rawtypes", "unused"})
    protected List<String> GetData() {
        Set<String> epcSet = new HashSet<>(); // يستخدم لإزالة التكرارات
        synchronized (hmList_Lock) {
            for (var stringEPCModelEntry : hmList.entrySet()) {
                var val = (EPCModel) ((Map.Entry) stringEPCModelEntry).getValue();
                String epc;
                if (_ReadType == 0) {
                    epc = val._EPC;
                } else if (_ReadType == 1) {
                    epc = val._TID;
                } else {
                    epc = val._UserData;
                }
                epcSet.add(epc); // تُضاف تلقائياً بدون تكرار
            }
        }
        return new ArrayList<>(epcSet); // تحويل Set إلى List
    }


    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        Log.d("PDADemo", "onKeyDown keyCode = " + keyCode);
        if ((Adapt.DEVICE_TYPE_HY820 == Adapt.getDeviceType() && (keyCode == KeyEvent.KEYCODE_F9 /* RFID扳机*/ || keyCode == 285  /* 左快捷*/ || keyCode == 286  /* 右快捷*/))
                || ((Adapt.getSN().startsWith("K3")) && (keyCode == KeyEvent.KEYCODE_F1 || keyCode == KeyEvent.KEYCODE_F5))
                || ((Adapt.getSN().startsWith("K6")) && (keyCode == KeyEvent.KEYCODE_F1 || keyCode == KeyEvent.KEYCODE_F5))) {

            isRead = true;
            if (!isKeyDown) {

                isKeyDown = true;
                if (!isStartPingPong) {
                    Pingpong_Stop();
                    isStartPingPong = true;
                    if ("6C".equals("6C")) {
                        GetEPC_6C();
                    } else {
                        CLReader.Get6B(_NowAntennaNo + "|1" + "|1" + "|"
                                + "1,000F");
                    }
                }
            } else {
                if (keyDownCount < 10000)
                    keyDownCount++;
            }

        }
        return super.onKeyDown(keyCode, event);
    }

    @Override
    public boolean onKeyUp(int keyCode, KeyEvent event) {
        Log.d("PDADemo", "onKeyUp keyCode = " + keyCode);
        if ((Adapt.DEVICE_TYPE_HY820 == Adapt.getDeviceType() && (keyCode == KeyEvent.KEYCODE_F9 /* RFID扳机*/ || keyCode == 285  /* 左快捷*/ || keyCode == 286  /* 右快捷*/))
                || ((Adapt.getSN().startsWith("K3")) && (keyCode == KeyEvent.KEYCODE_F1 || keyCode == KeyEvent.KEYCODE_F5))
                || ((Adapt.getSN().startsWith("K6")) && (keyCode == KeyEvent.KEYCODE_F1 || keyCode == KeyEvent.KEYCODE_F5))) {

            CLReader.Stop();
            isStartPingPong = false;
            keyDownCount = 0;
            isKeyDown = false;
            isRead = false;

        }
        return super.onKeyUp(keyCode, event);
    }

    @Override
    public void OutPutEPC(EPCModel model) {
        if (!isStartPingPong)
            return;
        try {
            synchronized (hmList_Lock) {
                if (hmList.containsKey(model._EPC + model._TID)) {
                    EPCModel tModel = hmList.get(model._EPC + model._TID);
                    if (tModel != null) {
                        tModel._TotalCount++;
                        model._TotalCount = tModel._TotalCount;
                    }
                    hmList.remove(model._EPC + model._TID);
                    hmList.put(model._EPC + model._TID, model);
                } else {
                    hmList.put(model._EPC + model._TID, model);
                }
            }
        } catch (Exception ex) {
            Toast.makeText(this, "error" + ex.getMessage(), Toast.LENGTH_SHORT).show();
            Log.d("Debug", "Tags output exceptions:" + ex.getMessage());
        }

    }


    public void PingPong_Read() {
        if (isStartPingPong)
            return;
        isStartPingPong = true;
        Helper_ThreadPool.ThreadPool_StartSingle(() -> {
            try {
                if (!isPowerLowShow) {
                    if ("6C".equals("6C")) {
                        GetEPC_6C();
                    } else {
                        CLReader.Get6B(_NowAntennaNo + "|1" + "|1" + "|" + "1,000F");
                    }
                }
            } catch (Exception ignored) {
                Toast.makeText(this, "error" + ignored.getMessage(), Toast.LENGTH_SHORT).show();

            }
        });
    }


    public void Pingpong_Stop() {
        isStartPingPong = false;
        CLReader.Stop();
    }


    private void GetEPC_6C() {

        switch ("EPC") {
            case "EPC" -> UHFReader._Tag6C.GetEPC(_NowAntennaNo, 1);
            case "TID" -> UHFReader._Tag6C.GetEPC_TID(_NowAntennaNo, 1);
            case "UserData" -> UHFReader._Tag6C.GetEPC_TID_UserData(_NowAntennaNo, 1, 0, 6);
        }

    }


}