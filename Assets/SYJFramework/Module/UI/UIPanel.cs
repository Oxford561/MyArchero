/*******************************************************************
* Copyright(c) #YEAR# #COMPANY#
* All rights reserved.
*
* 文件名称: #SCRIPTFULLNAME#
* 简要描述:
* 
* 创建日期: #DATE#
* 作者:     #AUTHOR#
* 说明:  
******************************************************************/
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace SYJFramework
{

    public class UIPanel : MonoBehaviour
    {
        [HideInInspector]
        public float CloseTime;

        public void Open(IUIData data)
        {
            gameObject.SetActive(true);
            OnOpen(data);
        }

        protected virtual void OnOpen(IUIData data = null)
        {

        }

        public void Close()
        {
            OnClose();
        }

        protected virtual void OnClose()
        {
            //Destroy(gameObject);//目前直接删除对象
            gameObject.SetActive(false);
            CloseTime = Time.time;
        }
    }
}
