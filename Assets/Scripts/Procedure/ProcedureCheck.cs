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
using SYJFramework;

public class ProcedureCheck : ProcedureBase
{
    public override void OnEnter()
    {
        base.OnEnter();
        Debug.Log("ProcedureCheck OnEnter");

        // 判断游戏中是否存在缓存
        if (PlayerPrefs.HasKey("skip"))
        {
            // 存在游戏缓存 直接进入游戏
            GameEntry.UI.OpenUI("MainUIPanel");
        }
        else
        {
            // 没有游戏缓存，先播放过场动画
            GameEntry.UI.OpenUI("VideoUIPanel");
            PlayerPrefs.SetInt("skip", 1);
        }
    }

    public override void OnUpdate()
    {
        base.OnUpdate();
        Debug.Log("ProcedureCheck OnUpdate");
    }

    public override void OnLeave()
    {
        base.OnLeave();
        Debug.Log("ProcedureCheck OnLeave");
    }

    public override void OnDestroy()
    {
        base.OnDestroy();
        Debug.Log("ProcedureCheck OnDestroy");

    }
}