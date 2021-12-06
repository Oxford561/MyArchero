using LitJson;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;


namespace SYJFramework
{


    /// <summary>
    /// http 管理器
    /// </summary>
    public class HttpManager
    {
        public void Get(string url, HttpSendDataCallBack callBack, bool isGetData)
        {
            //从池中获取Http访问器
            // HttpRoutine http = GameEntry.Pool.DequeueClassObject<HttpRoutine>();
            // http.SendData(url, callBack, false, null, null, isGetData);
            HttpRoutine http = new HttpRoutine();
            http.SendData(url, callBack, false, null, null, isGetData);

        }

        public void Post(string url, HttpSendDataCallBack callBack, Dictionary<string, object> dic, string contentType, bool isGetData, bool isEncrypt)
        {
            string json = string.Empty;
            //web加密
            if (dic != null && isEncrypt == true)
            {
                // //客户端设备标识符
                // dic["deviceIdentifier"] = DeviceUtil.DeviceIdentifier;

                // //客户端设备型号
                // dic["deviceModel"] = DeviceUtil.DeviceModel;

                // long t = GameEntry.Socket.GetCurrServerTime();
                // //签名
                // dic["sign"] = EncryptUtil.Md5(string.Format("{0}:{1}", t, DeviceUtil.DeviceIdentifier));

                // //时间戳
                // dic["t"] = t;
            }

            Post(url, callBack, JsonMapper.ToJson(dic), contentType, isGetData);
            //GameEntry.Pool.EnqueueClassObject(dic);
        }
        public void Post(string url, HttpSendDataCallBack callBack, string json, string contentType, bool isGetData)
        {
            //从池中获取Http访问器
            // HttpRoutine http = GameEntry.Pool.DequeueClassObject<HttpRoutine>();
            // http.SendData(url, callBack, true, json, contentType, isGetData);
        }
    }
}
