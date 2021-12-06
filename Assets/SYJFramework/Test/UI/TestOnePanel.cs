﻿/*******************************************************************
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
using SYJFramework;
using UnityEngine;
using UnityEngine.UI;

public class TestOnePanelData : IUIData
{
    public string content;
}

public class TestOnePanel : UIPanel
{
    [SerializeField]
    private Button btn;
    [SerializeField]
    private Text content;
    private TestOnePanelData mData;

    protected override void OnOpen(IUIData data)
    {
        mData = data as TestOnePanelData;
        if (mData != null)
            content.text = mData.content;
    }

    public void BtnClick()
    {
        GameEntry.UI.CloseSelf(this);
    }

    public void Btn2Click()
    {
        GameEntry.UI.CloseSelf(this);
        GameEntry.UI.OpenUI("TestTwoPanel");
    }
}