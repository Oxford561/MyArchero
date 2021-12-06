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
using System;


public enum SYJLanguage
{
    /// <summary>
    /// 中文
    /// </summary>
    Chinese,
    /// <summary>
    /// 英文
    /// </summary>
    English
}

public class LocalizationManager
{

    /// <summary>
    /// 当前语言
    /// </summary>
    public SYJLanguage CurrLanguage { get; set; }

    public LocalizationManager()
    {
        Init();
    }

    private void Init()
    {
        switch (Application.systemLanguage)
        {
            default:
            case SystemLanguage.Chinese:
            case SystemLanguage.ChineseSimplified:
            case SystemLanguage.ChineseTraditional:
                CurrLanguage = SYJLanguage.Chinese;
                break;
            case SystemLanguage.English:
                CurrLanguage = SYJLanguage.English;
                break;
        }
    }

    /// <summary>
    /// 获取本地化文本内容
    /// </summary>
    /// <param name="key"></param>
    /// <param name="args"></param>
    /// <returns></returns>
    public string GetString(string key, params object[] args)
    {
        string value = null;
        // 获取配置文件数据 通过key 找到 value  TODO

        return value;
    }
}