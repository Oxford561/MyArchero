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

namespace SYJFramework
{


    /// <summary>
    /// 定时器
    /// </summary>
    public class TimeAction
    {
        /// <summary>
        /// 是否正在运行
        /// </summary>
        /// <value></value>
        public bool IsRuning { get; private set; }

        /// <summary>
        /// 是否暂停
        /// </summary>
        public bool m_IsPause = false;

        /// <summary>
        /// 当前运行的时间
        /// </summary>
        private float m_CurrRunTime;

        /// <summary>
        /// 当前循环的次数
        /// </summary>
        private int m_CurrLoop;

        /// <summary>
        /// 延迟时间
        /// </summary>
        private float m_DelayTime;

        /// <summary>
        /// 间隔（秒）
        /// </summary>
        private float m_Interval;

        /// <summary>
        /// 循环次数（-1，表示无限循环）
        /// </summary>
        private int m_Loop;

        /// <summary>
        /// 最后暂停的时间
        /// </summary>
        private float m_LastPauseTime;

        /// <summary>
        /// 暂停了多久
        /// </summary>
        private float m_PauseTime;

        /// <summary>
        /// 开始运行
        /// </summary>
        private Action m_OnStart;

        /// <summary>
        /// 运行中（回调参数表示剩余数量）
        /// </summary>
        private Action<int> m_OnUpdate;

        /// <summary>
        /// 运行完毕
        /// </summary>
        private Action m_OnComplete;

        /// <summary>
        /// 初始化
        /// </summary>
        /// <param name="delayTime">延迟时间</param>
        /// <param name="interval">间隔（秒）</param>
        /// <param name="loop">循环次数</param>
        /// <param name="onStart">开始运行</param>
        /// <param name="onUpdate">运行中，回调参数表示剩余次数</param>
        /// <param name="onComplete">运行完毕</param>
        public TimeAction Init(float delayTime, float interval, int loop, Action onStart = null, Action<int> onUpdate = null, Action onComplete = null)
        {
            m_DelayTime = delayTime;
            m_Interval = interval;
            m_Loop = loop;
            m_OnStart = onStart;
            m_OnUpdate = onUpdate;
            m_OnComplete = onComplete;

            return this;
        }

        /// <summary>
        /// 开始运行
        /// </summary>
        public void Run()
        {
            GameEntry.Time.AddTimeAction(this);

            // 设置当前运行的时间
            m_CurrRunTime = Time.realtimeSinceStartup;

            m_IsPause = false;
        }

        /// <summary>
        /// 停止运行
        /// </summary>
        public void Stop()
        {
            if (m_OnComplete != null) m_OnComplete();

            IsRuning = false;
            m_CurrLoop = 0;

            GameEntry.Time.RemoveTimeAction(this);
        }

        /// <summary>
        /// 暂停
        /// </summary>
        public void Pause()
        {
            m_LastPauseTime = Time.realtimeSinceStartup;
            m_IsPause = true;
        }

        /// <summary>
        /// 恢复（取消暂停）
        /// </summary>
        public void Resume()
        {
            m_IsPause = false;
            m_PauseTime = Time.realtimeSinceStartup - m_LastPauseTime;
        }

        internal void OnUpdate()
        {
            if (m_IsPause) return;

            //1、等待延迟时间
            if (Time.realtimeSinceStartup > m_CurrRunTime + m_PauseTime + m_DelayTime)
            {
                if (!IsRuning)
                {
                    //开始运行
                    m_CurrRunTime = Time.realtimeSinceStartup;
                    m_PauseTime = 0;
                    if (m_OnStart != null) m_OnStart();

                    IsRuning = true;
                }
            }

            if (!IsRuning) return;

            if (Time.realtimeSinceStartup > m_CurrRunTime + m_PauseTime)
            {
                m_CurrRunTime = Time.realtimeSinceStartup + m_Interval;
                m_PauseTime = 0;

                //处理 循环间隔 m_Interval 秒 执行一次
                if (m_OnUpdate != null) m_OnUpdate(m_Loop - m_CurrLoop);

                if (m_Loop > -1)
                {
                    m_CurrLoop++;
                    if (m_CurrLoop >= m_Loop) Stop();
                }
            }
        }
    }
}