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
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// 状态机基类
/// </summary>
public abstract class FsmBase
{
    /// <summary>
    /// 状态机编号
    /// </summary>
    /// <value></value>
    public int FsmId { get; private set; }

    /// <summary>
    /// 状态机拥有者
    /// </summary>
    /// <value></value>
    public Type Owner { get; private set; }

    /// <summary>
    /// 当前状态的类型
    /// </summary>
    public byte CurrStateType;

    public FsmBase(int fsmId)
    {
        FsmId = fsmId;
    }

    /// <summary>
    /// 关闭状态机
    /// </summary>
    public abstract void ShutDown();
}