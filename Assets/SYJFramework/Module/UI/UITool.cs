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

    /// <summary>
    /// UI 工具方法
    /// </summary>
    public class UITool
    {
        public const string uiPath = "UIPanel/";
        /// <summary>
        /// 默认 从 Resources 中 加载
        /// </summary>
        /// <param name="uiName"></param>
        /// <returns></returns>
        public static UIPanel Load(string uiName)
        {
            GameObject tempUI = Resources.Load<GameObject>(uiPath + uiName);
            if (tempUI == null)
            {
                Debug.LogError("加载的" + uiName + " UI不存在");
                return null;
            }
            UIPanel uiPanel = GameObject.Instantiate(tempUI).GetComponent<UIPanel>();
            return uiPanel;
        }
    }
}