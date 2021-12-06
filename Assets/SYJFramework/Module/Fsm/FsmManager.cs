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

public class FsmManager : IDisposable
{
    /// <summary>
    /// 状态机字典
    /// </summary>
    private Dictionary<int, FsmBase> m_FsmDic;

    /// <summary>
    /// 状态机的临时编号
    /// </summary>
    private int m_TemFsmId = 0;

    public FsmManager()
    {
        m_FsmDic = new Dictionary<int, FsmBase>();
    }

    /// <summary>
    /// 创建状态机
    /// </summary>
    /// <typeparam name="T">拥有者类型</typeparam>
    /// <param name="fsmId">状态机编号</param>
    /// <param name="owner">拥有者</param>
    /// <param name="states">状态数组</param>
    /// <returns></returns>
    public Fsm<T> Create<T>(int fsmId, T owner, FsmState<T>[] states) where T : class
    {
        Fsm<T> fsm = new Fsm<T>(fsmId, owner, states);
        m_FsmDic[fsmId] = fsm;
        return fsm;
    }

    public Fsm<T> Create<T>(T owner, FsmState<T>[] states) where T : class
    {
        return Create(m_TemFsmId++, owner, states);
    }

    /// <summary>
    /// 销毁状态机
    /// </summary>
    /// <param name="fsmId">状态机编号</param>
    public void DestoryFsm(int fsmId)
    {
        FsmBase fsm = null;
        if (m_FsmDic.TryGetValue(fsmId, out fsm))
        {
            fsm.ShutDown();
            m_FsmDic.Remove(fsmId);
        }
    }

    public void Dispose()
    {
        var enumerator = m_FsmDic.GetEnumerator();
        while (enumerator.MoveNext())
        {
            enumerator.Current.Value.ShutDown();
        }
        m_FsmDic.Clear();
    }
}