Shader "H3D/InGame/Others/Scroll 2 Layers Sine Addtive"
{
  Properties
  {
    _MainTex ("Base layer (RGB)", 2D) = "white" {}
    _MaskTex ("Mask(R _Main Alpha,B DetailTex Alpha)", 2D) = "white" {}
    _DetailTex ("2nd layer (RGB)", 2D) = "white" {}
    _ScrollX ("Base layer Scroll speed X", float) = 1
    _ScrollY ("Base layer Scroll speed Y", float) = 0
    _Scroll2X ("2nd layer Scroll speed X", float) = 1
    _Scroll2Y ("2nd layer Scroll speed Y", float) = 0
    _SineAmplX ("Base layer sine amplitude X", float) = 0.5
    _SineAmplY ("Base layer sine amplitude Y", float) = 0.5
    _SineFreqX ("Base layer sine freq X", float) = 10
    _SineFreqY ("Base layer sine freq Y", float) = 10
    _SineAmplX2 ("2nd layer sine amplitude X", float) = 0.5
    _SineAmplY2 ("2nd layer sine amplitude Y", float) = 0.5
    _SineFreqX2 ("2nd layer sine freq X", float) = 10
    _SineFreqY2 ("2nd layer sine freq Y", float) = 10
    _Color ("Color", Color) = (1,1,1,1)
    _MMultiplier ("Layer Multiplier", float) = 2
    _Alpha ("透明度", Range(0, 1)) = 1
  }
  SubShader
  {
    Tags
    { 
      "IGNOREPROJECTOR" = "true"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    LOD 200
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      LOD 200
      ZWrite Off
      Cull Off
      Blend SrcAlpha One
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _Time;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform float4 _DetailTex_ST;
      uniform float _ScrollX;
      uniform float _ScrollY;
      uniform float _Scroll2X;
      uniform float _Scroll2Y;
      uniform float _MMultiplier;
      uniform float _SineAmplX;
      uniform float _SineAmplY;
      uniform float _SineFreqX;
      uniform float _SineFreqY;
      uniform float _SineAmplX2;
      uniform float _SineAmplY2;
      uniform float _SineFreqX2;
      uniform float _SineFreqY2;
      uniform float4 _Color;
      uniform sampler2D _MainTex;
      uniform sampler2D _MaskTex;
      uniform sampler2D _DetailTex;
      uniform float _Alpha;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 color :COLOR;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float4 xlv_TEXCOORD1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float4 xlv_TEXCOORD1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          float4 tmpvar_1;
          float4 tmpvar_2;
          float4 tmpvar_3;
          tmpvar_3.w = 1;
          tmpvar_3.xyz = float3(in_v.vertex.xyz);
          float2 tmpvar_4;
          tmpvar_4.x = _ScrollX;
          tmpvar_4.y = _ScrollY;
          float2 tmpvar_5;
          tmpvar_5 = frac((tmpvar_4 * _Time.xy));
          tmpvar_1.xy = float2((TRANSFORM_TEX(in_v.texcoord.xy, _MainTex) + tmpvar_5));
          float2 tmpvar_6;
          tmpvar_6.x = _Scroll2X;
          tmpvar_6.y = _Scroll2Y;
          float2 tmpvar_7;
          tmpvar_7 = frac((tmpvar_6 * _Time.xy));
          tmpvar_1.zw = (TRANSFORM_TEX(in_v.texcoord.xy, _DetailTex) + tmpvar_7);
          float4 tmpvar_8;
          float _tmp_dvx_53 = sin((_Time * _SineFreqX));
          tmpvar_8 = float4(_tmp_dvx_53, _tmp_dvx_53, _tmp_dvx_53, _tmp_dvx_53);
          tmpvar_1.x = (tmpvar_1.x + (tmpvar_8 * _SineAmplX).x).x;
          float4 tmpvar_9;
          float _tmp_dvx_54 = sin((_Time * _SineFreqY));
          tmpvar_9 = float4(_tmp_dvx_54, _tmp_dvx_54, _tmp_dvx_54, _tmp_dvx_54);
          tmpvar_1.y = (tmpvar_1.y + (tmpvar_9 * _SineAmplY).x).x;
          float4 tmpvar_10;
          float _tmp_dvx_55 = sin((_Time * _SineFreqX2));
          tmpvar_10 = float4(_tmp_dvx_55, _tmp_dvx_55, _tmp_dvx_55, _tmp_dvx_55);
          tmpvar_1.z = (tmpvar_1.z + (tmpvar_10 * _SineAmplX2).x).x;
          float4 tmpvar_11;
          float _tmp_dvx_56 = sin((_Time * _SineFreqY2));
          tmpvar_11 = float4(_tmp_dvx_56, _tmp_dvx_56, _tmp_dvx_56, _tmp_dvx_56);
          tmpvar_1.w = (tmpvar_1.w + (tmpvar_11 * _SineAmplY2).x).x;
          tmpvar_2 = ((_MMultiplier * _Color) * in_v.color);
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_3));
          out_v.xlv_TEXCOORD0 = tmpvar_1;
          out_v.xlv_TEXCOORD1 = tmpvar_2;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 c_1;
          float4 tmpvar_2;
          tmpvar_2 = tex2D(_MaskTex, in_f.xlv_TEXCOORD0.xy);
          c_1.xyz = ((tex2D(_MainTex, in_f.xlv_TEXCOORD0.xy) * tex2D(_DetailTex, in_f.xlv_TEXCOORD0.zw)) * in_f.xlv_TEXCOORD1).xyz.xyz;
          c_1.w = ((tmpvar_2.x * tmpvar_2.y) * (_Alpha * in_f.xlv_TEXCOORD1.w));
          out_f.color = c_1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "H3D/InGame/SceneStaticObjects/SimpleDiffuse ( no Supports Lightmap)"
}
