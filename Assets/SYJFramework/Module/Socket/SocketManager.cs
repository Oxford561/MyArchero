using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace SYJFramework
{


    /// <summary>
    /// Socket管理器
    /// </summary>
    public class SocketManager : IDisposable
    {

        #region 变量参数

        [Header("每帧最大发送数量")]
        public int MaxSendCount = 5;

        [Header("每次发包最大字节数量")]
        public int MaxSendByteCount = 1024;

        [Header("每帧最大接收数量")]
        public int MaxReceiveCount = 5;

        [Header("心跳间隔 秒")]
        public int HeartbeatInterval = 10;

        /// <summary>
        /// 上次心跳时间
        /// </summary>
        private float m_PrevHeartbeatInterval = 0;

        /// <summary>
        /// PING值(毫秒)
        /// </summary>
        [HideInInspector]
        public int PingValue;

        /// <summary>
        /// 游戏服务器的时间
        /// </summary>
        [HideInInspector]
        public long GameServerTime;

        /// <summary>
        /// 和服务器对表的时刻
        /// </summary>
        [HideInInspector]
        public float CheckServerTime;


        /// <summary>
        /// 是否已连接到了服务器
        /// </summary>
        private bool m_IsConnectToMainSocket = false;


        /// <summary>
        /// 发送数据的MemoryStream
        /// </summary>
        public MMO_MemoryStream SocketSendMS { get; private set; }
        /// <summary>
        /// 接收数据的MemoryStream
        /// </summary>
        public MMO_MemoryStream SocketReceiveMS { get; private set; }


        /// <summary>
        /// 主Socket
        /// </summary>
        private SocketTcpRoutine m_MainSocket;

        /// <summary>
        /// SocketTcp访问器链表
        /// </summary>
        private LinkedList<SocketTcpRoutine> m_SocketTcpRoutineList;

        /// <summary>
        /// Socket 接收的数据回调
        /// </summary>
        public Action<byte[]> OnReceiveDataCallBack;

        #endregion

        public SocketManager()
        {
            m_SocketTcpRoutineList = new LinkedList<SocketTcpRoutine>();

            SocketSendMS = new MMO_MemoryStream();
            SocketReceiveMS = new MMO_MemoryStream();

            Init();
        }

        /// <summary>
        /// 初始化 Socket 连接
        /// </summary>
        private void Init()
        {
            m_MainSocket = CreateSocketTcpRoutine();
            m_MainSocket.OnConnectOK = () =>
            {
            //已经建立了连接
            m_IsConnectToMainSocket = true;
            //GameEntry.Event.CommonEvent.Dispatch(SysEventId.OnConnectOKToMainSocket);
        };

            m_MainSocket.OnReceiveDataCallBack = (byte[] data) =>
            {
                if (OnReceiveDataCallBack != null)
                {
                    OnReceiveDataCallBack(data);
                }
            };

            //SocketProtoListener.AddProtoListener();
        }


        #region 提供外界调用 Connect 和 SendMsg 方法

        /// <summary>
        /// 主Socket连接服务器
        /// </summary>
        /// <param name="ip"></param>
        /// <param name="port"></param>
        public void ConnectToMainSocket(string ip, int port)
        {
            m_MainSocket.Connect(ip, port);
        }

        /// <summary>
        /// 主Socket发送消息
        /// </summary>
        /// <param name="buffer"></param>
        public void SendMainMsg(byte[] buffer)
        {
            m_MainSocket.SendMsg(buffer);
        }

        /// <summary>
        /// 获取当前的Socket服务器时间
        /// </summary>
        /// <returns></returns>
        public long GetCurrServerTime()
        {
            return (int)((Time.realtimeSinceStartup - CheckServerTime) * 1000) + GameServerTime;
        }

        #endregion


        #region SocketTcp 访问器相关

        /// <summary>
        /// 创建SocketTcp访问器
        /// </summary>
        /// <returns></returns>
        public SocketTcpRoutine CreateSocketTcpRoutine()
        {
            //从对象池中取出访问器
            //return GameEntry.Pool.DequeueClassObject<SocketTcpRoutine>();
            return new SocketTcpRoutine();
        }

        /// <summary>
        /// 注册SocketTcp访问器
        /// </summary>
        /// <param name="routine"></param>
        internal void RegisterSocketTcpRoutine(SocketTcpRoutine routine)
        {
            m_SocketTcpRoutineList.AddFirst(routine);
        }

        /// <summary>
        /// 移除SocketTcp访问器
        /// </summary>
        /// <param name="routine"></param>
        internal void RemoveSocketTcpRoutine(SocketTcpRoutine routine)
        {
            m_SocketTcpRoutineList.Remove(routine);
        }

        #endregion

        internal void OnUpdate()
        {
            for (LinkedListNode<SocketTcpRoutine> curr = m_SocketTcpRoutineList.First; curr != null; curr = curr.Next)
            {
                curr.Value.OnUpdate();
            }

            // 发送心跳
            if (m_IsConnectToMainSocket)
            {
                if (Time.realtimeSinceStartup > m_PrevHeartbeatInterval + HeartbeatInterval)
                {
                    //循环定时
                    m_PrevHeartbeatInterval = Time.realtimeSinceStartup;

                    //发送心跳
                    // System_HeartbeatProto proto = new System_HeartbeatProto();
                    // proto.LocalTime = Time.realtimeSinceStartup * 1000;
                    // CheckServerTime = Time.realtimeSinceStartup;
                    // SendMainMsg(proto);
                }
            }
        }

        public void Dispose()
        {
            m_SocketTcpRoutineList.Clear();

            m_IsConnectToMainSocket = false;

            // GameEntry.Pool.EnqueueClassObject(m_MainSocket);
            //SocketProtoListener.RemoveProtoListener();

            SocketSendMS.Dispose();
            SocketSendMS.Close();
            SocketReceiveMS.Dispose();
            SocketReceiveMS.Close();
        }
    }
}



// 以后可能用到的方法

/*
   /// <summary>
   /// 主Socket发送消息
   /// </summary>
   /// <param name="buffer"></param>
   public void SendMainMsg(IProto proto)
   {
#if DEBUG_LOG_PROTO
           Debug.Log("<color=#ffa200>发送消息:</color><color=#FFFB80>" + proto.ProtoEnName + " " + proto.ProtoCode + "</color>");
           Debug.Log("<color=#ffdeb3>==>>" + JsonUtility.ToJson(proto) + "</color>");
#endif
       m_MainSocket.SendMsg(proto.ToArray());
   }

   */
