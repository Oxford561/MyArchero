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

/// <summary>
/// 暂时 Launcher 阶段不需要做什么，直接进入 Check 流程
/// </summary>
public class ProcedureLauncher : ProcedureBase
{
    public override void OnEnter()
    {
        base.OnEnter();
		
		// 框架 bug 不能直接在 最初始的流程快速切换到其他流程，不然会报错
        GameEntry.Time.CreateTimeAction().Init(0.01f, 0, 0, () =>
        {
            GameEntry.Procedure.ChangeState(ProcedureState.Check);
        }, null, null).Run();
    }

    public override void OnLeave()
    {
        base.OnLeave();
        Debug.Log("ProcedureLauncher OnLeave");
    }

    public override void OnDestroy()
    {
        base.OnDestroy();
        Debug.Log("ProcedureLauncher OnDestroy");

    }
}