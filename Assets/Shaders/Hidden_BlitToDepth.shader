Shader "Hidden/BlitToDepth"
{
  Properties
  {
    _MainTex ("Texture", any) = "" {}
    _Color ("Multiplicative color", Color) = (1,1,1,1)
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
