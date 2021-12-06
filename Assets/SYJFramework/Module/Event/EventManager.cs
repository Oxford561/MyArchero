using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;


/// <summary>
/// 事件管理器
/// </summary>
public class EventManager :  IDisposable
{
    /// <summary>
    /// Socket 事件
    /// </summary>
    public SocketEvent SocketEvent { get; private set; }
    /// <summary>
    /// 通用事件
    /// </summary>
    public CommonEvent CommonEvent { get; private set; }

    public EventManager()
    {
        SocketEvent = new SocketEvent();
        CommonEvent = new CommonEvent();
    }

    public void Dispose()
    {
        SocketEvent.Dispose();
        CommonEvent.Dispose();
    }
}

