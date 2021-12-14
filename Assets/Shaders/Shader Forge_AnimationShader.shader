Shader "Shader Forge/AnimationShader"
{
  Properties
  {
    _Tex ("Tex", 2D) = "white" {}
    _U ("U", float) = 7
    _V ("V", float) = 7
    _FPS ("FPS", float) = 50
    [HideInInspector] _Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
  }
  SubShader
  {
    Tags
    { 
      "IGNOREPROJECTOR" = "true"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    Pass // ind: 1, name: FORWARD
    {
      Name "FORWARD"
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "FORWARDBASE"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
        "SHADOWSUPPORT" = "true"
      }
      ZWrite Off
      Blend SrcAlpha OneMinusSrcAlpha
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile DIRECTIONAL
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      //uniform float4 _Time;
      uniform float4 _TimeEditor;
      uniform sampler2D _Tex;
      uniform float4 _Tex_ST;
      uniform float _U;
      uniform float _V;
      uniform float _FPS;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float2 xlv_TEXCOORD0 :TEXCOORD0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 xlv_TEXCOORD0 :TEXCOORD0;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          float4 tmpvar_1;
          tmpvar_1.w = 1;
          tmpvar_1.xyz = float3(in_v.vertex.xyz);
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_1));
          out_v.xlv_TEXCOORD0 = in_v.texcoord.xy;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          float4 finalRGBA_2;
          float4 _Tex_var_3;
          float x_4;
          x_4 = (_FPS * (_Time + _TimeEditor).y).x;
          float tmpvar_5;
          if((x_4<0))
          {
              tmpvar_5 = (-floor((-x_4)));
          }
          else
          {
              tmpvar_5 = floor(x_4);
          }
          float2 tmpvar_6;
          tmpvar_6.x = _U;
          tmpvar_6.y = (-_V);
          float2 tmpvar_7;
          float _tmp_dvx_58 = (1 / tmpvar_6);
          tmpvar_7 = float2(_tmp_dvx_58, _tmp_dvx_58);
          float tmpvar_8;
          tmpvar_8 = floor((tmpvar_5 * tmpvar_7.x));
          float2 tmpvar_9;
          tmpvar_9.x = in_f.xlv_TEXCOORD0.x;
          tmpvar_9.y = ((-in_f.xlv_TEXCOORD0.y) + 1);
          float2 tmpvar_10;
          tmpvar_10.x = (tmpvar_5 - (_U * tmpvar_8));
          tmpvar_10.y = tmpvar_8;
          float4 tmpvar_11;
          float2 P_12;
          P_12 = ((((tmpvar_9 + tmpvar_10) * tmpvar_7) * _Tex_ST.xy) + _Tex_ST.zw);
          tmpvar_11 = tex2D(_Tex, P_12);
          _Tex_var_3 = tmpvar_11;
          float4 tmpvar_13;
          tmpvar_13.xyz = float3(_Tex_var_3.xyz);
          tmpvar_13.w = _Tex_var_3.w;
          finalRGBA_2 = tmpvar_13;
          tmpvar_1 = finalRGBA_2;
          out_f.color = tmpvar_1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Diffuse"
}
