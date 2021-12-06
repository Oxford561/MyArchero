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


    public class GameEntry : MonoBehaviour
    {
        /// <summary>
        /// 时间管理器
        /// </summary>
        public static TimeManager Time;

        /// <summary>
        /// 事件管理器
        /// </summary>
        public static EventManager Event;

        /// <summary>
        /// http 管理器
        /// </summary>
        public static HttpManager Http;

        /// <summary>
        /// Socket 管理器
        /// </summary>
        public static SocketManager Socket;

        /// <summary>
        /// Fsm 管理器
        /// </summary>
        public static FsmManager Fsm;

        /// <summary>
        /// 流程管理器
        /// </summary>
        public static ProcedureManager Procedure;

        /// <summary>
        /// 池 管理器
        /// </summary>
        public static PoolManager Pool;

        /// <summary>
        /// 本地化 管理器
        /// </summary>
        public static LocalizationManager Localization;

        /// <summary>
        /// UI 管理器
        /// </summary>
        public static UIManager UI;

        /// <summary>
        /// 资源管理器
        /// </summary>
        public static ResManager Res;

        /// <summary>
        /// 音频管理器
        /// </summary>
        public static AudioManager Audio;

        /// <summary>
        /// 用于 开启 协程（后面考虑删除）
        /// </summary>
        public static GameEntry Instance;

        void Awake()
        {
            Instance = this;
            Time = new TimeManager();
            Pool = new PoolManager();
            Event = new EventManager();
            Http = new HttpManager();
            Socket = new SocketManager();
            Fsm = new FsmManager();
            Procedure = new ProcedureManager();
            Localization = new LocalizationManager();
            UI = new UIManager();
            Res = new ResManager();
            Audio = new AudioManager();


            DontDestroyOnLoad(this);
        }

        private void Update()
        {
            Time.OnUpdate();
            Socket.OnUpdate();
            Procedure.OnUpdate();
            UI.OnUpdate();
        }

        private void OnDestroy()
        {
            Time.Dispose();
            Event.Dispose();
            Socket.Dispose();
            Fsm.Dispose();
            Procedure.Dispose();
            Pool.Dispose();
            UI.Dispose();
        }
    }
}
