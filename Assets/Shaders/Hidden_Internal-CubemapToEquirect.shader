Shader "Hidden/Internal-CubemapToEquirect"
{
  Properties
  {
    _MainTex ("Texture", Cube) = "" {}
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
      ZWrite Off
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform samplerCUBE _MainTex;
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
          out_v.xlv_TEXCOORD0 = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float2 tmpvar_1;
          tmpvar_1 = ((in_f.xlv_TEXCOORD0 * float2(6.283185, 3.141593)) + float2(-3.141593, (-1.570796)));
          float2 tmpvar_2;
          float _tmp_dvx_89 = cos(tmpvar_1);
          tmpvar_2 = float2(_tmp_dvx_89, _tmp_dvx_89);
          float2 tmpvar_3;
          float _tmp_dvx_90 = sin(tmpvar_1);
          tmpvar_3 = float2(_tmp_dvx_90, _tmp_dvx_90);
          float3 tmpvar_4;
          tmpvar_4.x = (tmpvar_3.x * tmpvar_2.y);
          tmpvar_4.y = tmpvar_3.y;
          tmpvar_4.z = (tmpvar_2.x * tmpvar_2.y);
          float4 tmpvar_5;
          tmpvar_5 = texCUBE(_MainTex, tmpvar_4);
          out_f.color = tmpvar_5;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
