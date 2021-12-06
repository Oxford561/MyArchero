using LitJson;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Networking;

namespace SYJFramework
{


    /// <summary>
    /// Http??????????
    /// </summary>
    /// <param name="args"></param>
    public delegate void HttpSendDataCallBack(HttpCallBackArgs args);

    /// <summary>
    /// Http??????
    /// </summary>
    public class HttpRoutine
    {
        #region 发送数据回调
        /// <summary>
        /// Http??????
        /// </summary>
        private HttpSendDataCallBack m_CallBack;

        /// <summary>
        /// Http回调参数
        /// </summary>
        private HttpCallBackArgs m_CallBackArgs;

        /// <summary>
        /// 服务器是否返回 Bytes
        /// </summary>
        private bool m_IsGetData = false;

        /// <summary>
        /// 是否繁忙
        /// </summary>
        public bool Isbusy { get; private set; }
        #endregion

        public HttpRoutine()
        {
            m_CallBackArgs = new HttpCallBackArgs();
        }

        #region SendData 发送数据
        /// <summary>
        /// ???????
        /// </summary>
        /// <param name="url">???</param>
        /// <param name="callBack">???</param>
        /// <param name="isPost">false:Get????, true:Post????</param>
        /// <param name="dic">????????????</param>
        public void SendData(string url, HttpSendDataCallBack callBack, bool isPost, string json, string contentType, bool isGetData)
        {
            if (Isbusy)
            {
                Debug.Log("服务器繁忙");
                return;
            }
            Isbusy = true;

            m_CallBack = callBack;//???????
            m_IsGetData = isGetData;

            //GameEntry.Log(LogCategory.Proto, "?????????Url=>" + url);

            if (!isPost)
            {
                GetUrl(url);
            }
            else
            {
                PostUrl(url, json == null ? "" : json, contentType);
            }
        }
        #endregion

        #region GetUrl Get????
        /// <summary>
        /// Get????
        /// </summary>
        /// <param name="url"></param>
        private void GetUrl(string url)
        {
            UnityWebRequest data = UnityWebRequest.Get(url);
            GameEntry.Instance.StartCoroutine(Request(data));
        }
        #endregion

        #region PostUrl Post????
        /// <summary>
        /// Post????
        /// </summary>
        /// <param name="url"></param>
        /// <param name="json"></param>
        private void PostUrl(string url, string json, string contentType)
        {
            //??????????
            WWWForm form = new WWWForm();

            if (json != null)
            {
                //GameEntry.Log(LogCategory.Proto, "????????Json=>" + json);
                //?????????
                form.AddField("", json);
            }

            UnityWebRequest data = UnityWebRequest.Post(url, form);
            if (!string.IsNullOrEmpty(contentType)) data.SetRequestHeader("Content-Type", contentType);

            //GameEntry.Http.StartCoroutine(Request(data));
            GameEntry.Instance.StartCoroutine(Request(data));
        }
        #endregion


        #region Request 发出请求
        /// <summary>
        /// ?????????
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        private IEnumerator Request(UnityWebRequest data)
        {
            yield return data.SendWebRequest();//???UnityWebRequest???

            Isbusy = false;
            if (data.isNetworkError || data.isHttpError)//访问出错
            {
                if (m_CallBack != null)
                {
                    m_CallBackArgs.HasError = true;
                    m_CallBackArgs.Value = data.error;

                    if (!m_IsGetData)
                    {
                        //GameEntry.Log(LogCategory.Proto, "??????????Url=>" + data.url);
                        //GameEntry.Log(LogCategory.Proto, "??????????Json=>" + JsonUtility.ToJson(m_CallBackArgs));
                    }

                    m_CallBack(m_CallBackArgs);//???????
                }
            }
            else
            {
                if (m_CallBack != null)
                {
                    m_CallBackArgs.HasError = false;
                    m_CallBackArgs.Value = data.downloadHandler.text;

                    if (!m_IsGetData)
                    {
                        //GameEntry.Log(LogCategory.Proto, "??????????Url=>" + data.url);
                        //GameEntry.Log(LogCategory.Proto, "??????????Json=>" + JsonUtility.ToJson(m_CallBackArgs));
                    }

                    m_CallBackArgs.Data = data.downloadHandler.data;
                    m_CallBack(m_CallBackArgs);//???????
                }
            }
            data.Dispose();
            data = null;

            //??????
            //GameEntry.Pool.EnqueueClassObject(this);
        }
    }
    #endregion

}
