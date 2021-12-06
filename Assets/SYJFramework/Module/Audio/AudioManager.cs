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
using DG;

namespace SYJFramework
{
    public class AudioManager
    {
        /// <summary>
        /// 音源
        /// </summary>
        private AudioSource mAudioSource;

        /// <summary>
        /// 上一个播放的背景音乐
        /// </summary>
        private AudioClip mPrevAudioClip;

        /// <summary>
        /// 上一个播放的背景音乐 
        /// </summary>
        private string mAudioName;

        /// <summary>
        /// 最大音量
        /// </summary>
        private float mMaxVolume = 0.5f;

        /// <summary>
        /// 背景音量，取值：0-1f
        /// </summary>
        public float BgVolume = 1f;
        public float effectVolume = 1f;

        private AudioSource bgAudioSource;
        private AudioSource effectAudioSource;

        //声音播放器缓存列表（类似PoolManager）
        private List<AudioInfo> m_AudioList = new List<AudioInfo>();

        private bool isOpenBg = true;
        public bool isOpenSound = true;

        internal AudioManager()
        {
            mAudioSource = GameEntry.Instance.GetComponent<AudioSource>();
            mAudioSource.volume = BgVolume;//音量
            mAudioSource.loop = true;//是否
            mAudioSource.spatialBlend = 0f;//2D音乐


            InitConfig();
        }

        void InitConfig()
        {
            // 读取缓存文件设置
            if (PlayerPrefs.HasKey("Music"))
            {
                bool isMusic = PlayerPrefs.GetInt("Music") == 1;

                if (isMusic)
                {
                    StartBg();
                }
                else
                {
                    StopBg();
                }
            }

            if (PlayerPrefs.HasKey("Sound"))
            {
                bool isSound = PlayerPrefs.GetInt("Sound") == 1;
                if (isSound)
                {
                    StartSound();
                }
                else
                {
                    StopSound();
                }
            }
        }

        public void StopBg()
        {
            mAudioSource.volume = 0f;
            isOpenBg = false;
        }

        public void StartBg()
        {
            mAudioSource.volume = 1f;
            isOpenBg = true;
        }

        #region 播放背景音乐

        /// <summary>
        /// 播放背景音乐
        /// </summary>
        /// <param name="name"></param>
        public void Play(string name)
        {
            mAudioName = name;
            GameEntry.Instance.StartCoroutine(DoPlay());
        }

        private IEnumerator DoPlay()
        {
            float fadeOut = 1;//淡出需要多少秒
            float fadeIn = 1;//淡入需要多少秒
            float delay = 0;//延迟时间

            AudioClip audioClip = null;
            audioClip = UnityEditor.AssetDatabase.LoadAssetAtPath<AudioClip>(string.Format("Assets/{0}", mAudioName));
            if (mAudioSource.isPlaying && mAudioSource.clip == audioClip)
            {
                yield return 0;
            }
            else
            {
                float time1 = Time.time;
                //开始播放
                //检查是否有未完成的要播放的音乐
                if (mPrevAudioClip != null)
                {
                    //先把上一个音乐 淡出
                    yield return GameEntry.Instance.StartCoroutine(StartFadeOut(fadeOut));
                }

                //设置延迟
                float time2 = Time.time - time1;
                if (delay > time2)
                {
                    yield return new WaitForSeconds(delay - time2);
                }

                mAudioSource.clip = audioClip;
                mPrevAudioClip = audioClip;
                mAudioSource.Play();

                //声音淡入
                yield return GameEntry.Instance.StartCoroutine(StartFadeIn(fadeIn));
            }
        }


        /// <summary>
        /// 声音淡出
        /// </summary>
        /// <param name="fadeOut"></param>
        /// <returns></returns>
        private IEnumerator StartFadeOut(float fadeOut)
        {
            float time = 0f;
            while (time <= fadeOut)
            {
                if (time != 0)
                {
                    mAudioSource.volume = Mathf.Lerp(mMaxVolume, 0f, time / fadeOut);
                }
                time += Time.deltaTime;
                yield return 1;
            }
            mAudioSource.volume = 0;
        }

        /// <summary>
        /// 声音淡入
        /// </summary>
        /// <param name="fadeIn"></param>
        /// <returns></returns>
        private IEnumerator StartFadeIn(float fadeIn)
        {
            if (!isOpenBg) yield break;//背景音乐开关

            float time = 0f;
            while (time <= fadeIn)
            {
                if (time != 0)
                {
                    mAudioSource.volume = Mathf.Lerp(0f, mMaxVolume, time / fadeIn);
                }
                time += Time.deltaTime;
                yield return 1;
            }
            mAudioSource.volume = mMaxVolume;
        }
        #endregion

        #region 播放音效

        public void PlayUIAudioEffect(string audioName, Vector3 pos, bool is3D = false)
        {
            //Play("Download/Audio/ UI/" + type.ToString() + ".mp3", Vector3.z);
            Play(audioName, pos, is3D);
        }

        /// <summary>
        /// 在指定的位置，播放指定名称的声音
        /// </summary>
        /// <param name="AudioNameID"></param>
        /// <param name="pos"></param>
        public void Play(string audioPath, Vector3 pos, bool is3D = false)
        {
            AudioClip audioClip = UnityEditor.AssetDatabase.LoadAssetAtPath<AudioClip>(string.Format("Assets/{0}", audioPath));
            if (audioClip == null) return;

            AudioInfo info = FindSameAudio(audioClip.name);
            if (info != null)
            {
                //如果缓存列表中 有相同的声音
                //更新其audioclip，确保其是最新的，非常重要！
                info.AudioName = audioClip.name;
                info.CurrAudioSource.clip = audioClip;

                //开始播放
                info.Play(pos, is3D);
            }
            else
            {
                //移除过期的
                RemoveOverSound();

                //新建一个
                info = new AudioInfo(audioClip, GameEntry.Instance.gameObject);
                m_AudioList.Add(info);

                //开始播放
                info.Play(pos, is3D);
            }
        }

        /// <summary>
        /// 停止所有声音
        /// </summary>
        public void StopAllAudio()
        {
            for (int i = m_AudioList.Count - 1; i >= 0; i--)
            {
                m_AudioList[i].Destroy();
            }

            m_AudioList.Clear();
        }

        public void StartSound()
        {
            for (int i = m_AudioList.Count - 1; i >= 0; i--)
            {
                m_AudioList[i].CurrAudioSource.volume = 1f;
            }
            isOpenSound = true;
        }

        public void StopSound()
        {
            for (int i = m_AudioList.Count - 1; i >= 0; i--)
            {
                m_AudioList[i].CurrAudioSource.volume = 0f;
            }
            isOpenSound = false;
        }

        /// <summary>
        /// 查找是指定名称的声音，是否在列表中存在，并且可用于播放新声音
        /// 规则：
        ///    1：如果列表中有同名已经播放完毕的声音，则直接将其返回。
        ///    2：如果有两个或更多个同名的，但是正在播放的声音，则把其中结束时刻最早的那个直接返回（这样就会把结束期最早的那个提前停止，改为播放新声音了）
        ///       之所以判断两个，是为了增加真实感，仅判断1个会看到有点假。如果太多则会太浪费cpu和内存
        ///    3：如果以上两个条件都不满足，则直接返回null
        /// </summary>
        /// <param name="audioName"></param>
        /// <returns></returns>
        private AudioInfo FindSameAudio(string audioName)
        {
            //----------------------
            //如果列表中已经播放完了，则将其直接返回
            foreach (AudioInfo infoItem in m_AudioList)
            {
                if (Time.time > infoItem.PlayEndTime)
                {
                    return infoItem;
                }
            }
            //程序执行到这里，表示都没有播放完


            //----------------------
            //判断是否存在没有播放完毕的同名的声音
            List<AudioInfo> infoArray = new List<AudioInfo>();
            foreach (AudioInfo infoItem in m_AudioList)
            {
                if (infoItem.AudioName == audioName)
                {
                    infoArray.Add(infoItem);
                }
            }

            //如果目前只有一个正在播放的同名声音，或者一个也没有，则直接返回
            if (infoArray.Count <= 1)
            {
                infoArray = null;
                return null;
            }
            //程序执行到这里，就表示至少已经存在2个同名的、正在播放的声音。则把结束时刻最早的那个作为返回值返回(这样我们就实现了停止最早的那个声音，让其改为播放新声音了)
            AudioInfo info = infoArray[0];
            for (int i = 1; i < infoArray.Count; i++)
            {
                if (info.PlayEndTime > infoArray[i].PlayEndTime)
                {
                    info = infoArray[i];
                }
            }
            infoArray = null;
            return info;
        }

        private void RemoveOverSound()
        {
            //如果列表中的个数超过了8个，则先把已经播放完毕的， 全部移除掉
            if (m_AudioList.Count >= 8)
            {
                for (int i = m_AudioList.Count - 1; i >= 0; i--)
                {
                    if (Time.time > m_AudioList[i].PlayEndTime)
                    {
                        AudioInfo item = m_AudioList[i];
                        m_AudioList.Remove(item);
                        item.Destroy();//重要！
                    }
                }
            }

            //如果列表中的个数仍然超过8个，则把最早结束的移除掉，直到少于8个
            while (m_AudioList.Count >= 8)
            {
                AudioInfo item = m_AudioList[0];
                foreach (AudioInfo info2 in m_AudioList)
                {
                    if (item.PlayEndTime > info2.PlayEndTime)
                    {
                        item = info2;
                    }
                }
                m_AudioList.Remove(item);
                item.Destroy();//重要！
            }
        }

        #endregion
    }


    //声音播放器(音源)
    public class AudioInfo
    {
        public AudioSource CurrAudioSource;//音频播放器
        public string AudioName;//音效名称字符串
        public float PlayEndTime = 0;//播放结束时刻
        public bool Is3D;

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="audioclip">音效</param>
        /// <param name="root">对应的GameObject的父物体</param>
        public AudioInfo(AudioClip audioclip, GameObject root = null)
        {
            AudioName = audioclip.name;

            //--------------
            //新建一个gameObject
            GameObject obj = new GameObject("Audio_" + AudioName);
            if (root != null)
            {
                obj.transform.parent = root.transform;
            }

            //这个可以跨场景不释放，重要！！！
            Object.DontDestroyOnLoad(obj);


            //在这个新建的gameObject上挂上一个AudioClip组件
            CurrAudioSource = obj.AddComponent<AudioSource>();
            CurrAudioSource.loop = false;//不循环
            CurrAudioSource.volume = GameEntry.Audio.effectVolume;//音量大小(0-1)
            // CurrAudioSource.rolloffMode = AudioRolloffMode.Linear;//按距离衰减模式---线性衰减
            // CurrAudioSource.minDistance = 30;//按距离衰减模式---起始衰减距离（当AudioSource到AudioListener之间的距离，大于这个数值时才开始音量衰减）
            // CurrAudioSource.maxDistance = 200;//按距离衰减模式---结束衰减距离（当AudioSource到AudioListener之间的距离，小于这个数值时则声音再也听不到了
            CurrAudioSource.clip = audioclip;
            CurrAudioSource.panStereo = 0;
            CurrAudioSource.playOnAwake = false;
        }

        /// <summary>
        /// 释放这个类对象时这个函数将会被手工调用
        /// </summary>
        public void Destroy()
        {
            //停止播放音效
            Stop();

            //把对应的GameObject也释放掉
            Object.Destroy(this.CurrAudioSource.gameObject);
        }

        /// <summary>
        /// 在指定的坐标点处，开始播放音效
        /// </summary>
        /// <param name="pos">3D场景内的一个坐标点，要求在这个点处播放声音（备注:u3d的3d声音跟声源的位置有关系，越远则声音越小）</param>
        public void Play(Vector3 pos, bool is3D = false)
        {
            //记录下播放结束时刻
            PlayEndTime = Time.time + this.CurrAudioSource.clip.length;

            //把gameobject移动到要求的位置
            CurrAudioSource.gameObject.transform.position = pos;
            CurrAudioSource.Stop();

            //开始播放
            CurrAudioSource.spatialBlend = is3D ? 1 : 0;
            if (GameEntry.Audio.isOpenSound)
                CurrAudioSource.Play();
        }

        /// <summary>
        /// 停止播放
        /// </summary>
        public void Stop()
        {
            CurrAudioSource.Stop();//停止播放声音
            PlayEndTime = 0f;//把播放结束时刻设置为0
        }
    }


}


