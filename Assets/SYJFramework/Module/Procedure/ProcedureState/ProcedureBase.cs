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
    /// 流程控制基类
    /// </summary>
    public class ProcedureBase : FsmState<ProcedureManager>
    {
        public override void OnEnter()
        {
            base.OnEnter();
            //GameEntry.Log(LogCategory.Procedure, CurrFsm.GetState(CurrFsm.CurrStateType).ToString() + "==>> OnEnter()");
        }

        public override void OnUpdate()
        {
            base.OnUpdate();
        }

        public override void OnLeave()
        {
            base.OnLeave();
            //GameEntry.Log(LogCategory.Procedure, CurrFsm.GetState(CurrFsm.CurrStateType).ToString() + "==>> OnLeave()");
        }

        public override void OnDestroy()
        {
            base.OnDestroy();

        }
    }
}