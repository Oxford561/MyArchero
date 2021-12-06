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

public class ProcedureGame : ProcedureBase
{
    public override void OnEnter()
    {
        base.OnEnter();
        Debug.Log("ProcedureGame OnEnter");
    }

    public override void OnUpdate()
    {
        base.OnUpdate();
        Debug.Log("ProcedureGame OnUpdate");
    }

    public override void OnLeave()
    {
        base.OnLeave();
        Debug.Log("ProcedureGame OnLeave");
    }

    public override void OnDestroy()
    {
        base.OnDestroy();
        Debug.Log("ProcedureGame OnDestroy");

    }
}