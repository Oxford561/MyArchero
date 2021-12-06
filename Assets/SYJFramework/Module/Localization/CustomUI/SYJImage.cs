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
using UnityEngine.UI;

namespace SYJFramework
{

    /// <summary>
    /// 自定义 Image
    /// </summary>
    public class SYJImage : Image
    {
        [Header("本地化语言的key")]
        [SerializeField]
        private string m_Localization;

        protected override void Start()
        {
            base.Start();
            if (GameEntry.Localization != null)
            {
                // 根据 key 找到对应的 资源路径 value
                string path = GameEntry.Localization.GetString(m_Localization);
                Texture2D texture = null;
#if UNITY_DEITOR
                texture = UnityEditor.AssetDatabase.LoadAssetAtPath<Texture2D>(path) as Texture2D;

                Sprite obj = Sprite.Create(texture, new Rect(0, 0, texture.width, texture.height), new Vector2(0.5f, 0.5f));
                sprite = obj;
                SetNativeSize();
#endif
            }
        }
    }
}