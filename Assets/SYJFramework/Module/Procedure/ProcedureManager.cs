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

namespace SYJFramework
{


    public enum ProcedureState
    {
        Launcher,
        Check,
        NoGame,
        Game
    }

    public class ProcedureManager : IDisposable
    {
        /// <summary>
        /// 当前流程状态机
        /// </summary>
        private Fsm<ProcedureManager> m_CurrFsm;
        /// <summary>
        /// 当前流程状态机
        /// </summary>
        public Fsm<ProcedureManager> CurrFsm { get { return m_CurrFsm; } }

        /// <summary>
        /// 当前流程状态Type
        /// </summary>
        public ProcedureState CurrProcedureState
        {
            get
            {
                return (ProcedureState)m_CurrFsm.CurrStateType;
            }
        }
        /// <summary>
        /// 当前流程
        /// </summary>
        public FsmState<ProcedureManager> CurrProcedure
        {
            get
            {
                return m_CurrFsm.GetState(m_CurrFsm.CurrStateType);
            }
        }

        public ProcedureManager()
        {
            Init();
        }

        /// <summary>
        /// 初始化
        /// </summary>
        public void Init()
        {
            //得到枚举的长度
            int count = Enum.GetNames(typeof(ProcedureState)).Length;
            FsmState<ProcedureManager>[] states = new FsmState<ProcedureManager>[count];
            states[(byte)ProcedureState.Launcher] = new ProcedureLauncher();
            states[(byte)ProcedureState.Check] = new ProcedureCheck();
            states[(byte)ProcedureState.NoGame] = new ProcedureNoGame();
            states[(byte)ProcedureState.Game] = new ProcedureGame();


            m_CurrFsm = GameEntry.Fsm.Create(this, states);
        }

        /// <summary>
        /// 切换状态
        /// </summary>
        public void ChangeState(ProcedureState state)
        {
            m_CurrFsm.ChangeState((byte)state);
        }

        public void OnUpdate()
        {
            m_CurrFsm.OnUpdate();
        }

        public void Dispose()
        {

        }
    }
}