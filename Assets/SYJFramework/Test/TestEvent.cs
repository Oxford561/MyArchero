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
using SYJFramework;
using UnityEngine;

public class TestEvent : MonoBehaviour
{
    void Start()
    {
        // 测试 通用事件 不用传数据
        GameEntry.Event.CommonEvent.AddEventListener(CommonEventId.OnNoMsgEvent, (object data) =>
        {
            Debug.Log("接收到了");
        });

		// 测试 通用事件 传数据
        GameEntry.Event.CommonEvent.AddEventListener(CommonEventId.OnHasMsgEvent, (object data) =>
        {
            Debug.Log("接收到了 "+ data.ToString());
        });

		// 测试 Socket 事件 传数据
        GameEntry.Event.SocketEvent.AddEventListener(SysEventId.LoadDataTableComplete, (byte[] data) =>
        {
            Debug.Log("接收到了 "+ System.Text.Encoding.UTF8.GetString(data));
        });
    }

    void Update()
    {
        // 测试 通用事件 不用传数据
        if (Input.GetKeyDown(KeyCode.Space))
        {
            GameEntry.Event.CommonEvent.Dispatch(CommonEventId.OnNoMsgEvent);
        }

		// 测试 通用事件 不用传数据
        if (Input.GetKeyDown(KeyCode.A))
        {
            GameEntry.Event.CommonEvent.Dispatch(CommonEventId.OnHasMsgEvent,"通用事件参数数据");
        }

		// 测试 Socket 事件 传数据
        if (Input.GetKeyDown(KeyCode.B))
        {
            GameEntry.Event.SocketEvent.Dispatch(SysEventId.LoadDataTableComplete,System.Text.Encoding.UTF8.GetBytes("撒旦"));
        }
    }
}