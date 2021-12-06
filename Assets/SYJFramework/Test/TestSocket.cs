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
using System.Text;
using SYJFramework;
using UnityEngine;

public class TestSocket : MonoBehaviour
{
    void Start()
    {
        // 建立连接
        GameEntry.Socket.ConnectToMainSocket("127.0.0.1", 17666);

        // 发送数据
        GameEntry.Socket.SendMainMsg(Encoding.UTF8.GetBytes("haha"));

        // 接收数据
        GameEntry.Socket.OnReceiveDataCallBack = (byte[] data) =>
        {
            Debug.Log("接收到了数据");
        };

    }

    void Update()
    {

    }
}