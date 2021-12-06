using System.Collections;
using System.Collections.Generic;
using UnityEngine;



/// <summary>
/// 系统事件编号(系统事件编号 采用4位 1001(10表示模块 01表示编号))
/// </summary>
public class SysEventId
{
    /// <summary>
    /// 数据表全部加载完毕
    /// </summary>
    public const ushort LoadDataTableComplete = 1001;

    /// <summary>
    /// 数据表单个加载完毕
    /// </summary>
    public const ushort LoadOneDataTableComplete = 1002;


}
