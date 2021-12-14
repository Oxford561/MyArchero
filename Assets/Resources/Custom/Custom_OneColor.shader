Shader "Custom/OneColor"
{
  Properties
  {
    _Color ("color", Color) = (1,1,1,1)
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
      // m_ProgramMask = 4
      
    } // end phase
  }
  FallBack "Diffuse"
}
