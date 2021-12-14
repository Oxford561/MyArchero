Shader "Hidden/BlitToDepth_MSAA"
{
  Properties
  {
    _MainTex ("DepthTexture", any) = "" {}
  }
  SubShader
  {
    Tags
    { 
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
      }
      ZTest Always
      Cull Off
      ColorMask 0
      // m_ProgramMask = 6
      
    } // end phase
  }
  FallBack Off
}
