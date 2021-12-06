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
using SYJFramework;
using UnityEngine;

public class TestUI : MonoBehaviour
{
    void Start()
    {
        //首先打开一个UI
        GameEntry.UI.OpenUI("TestOnePanel", UILevel.Common,new TestOnePanelData(){content = "hahahha"});
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space))
        {
			GameEntry.UI.CloseUI("TestOnePanel");
        }
    }
}