Shader "Custom/OutLight"
{
  Properties
  {
    _RimColor ("RimColor", Color) = (1,1,1,1)
    _RimPower ("RimPower", Range(0, 10)) = 0
    _TextureColor ("TextureColor", Color) = (0,0,0,1)
    _MainTex ("Base 2D", 2D) = "white" {}
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
        "RenderType" = "Opaque"
      }
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float3 _WorldSpaceCameraPos;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform sampler2D _MainTex;
      uniform float4 _RimColor;
      uniform float _RimPower;
      uniform float4 _TextureColor;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float3 normal :NORMAL;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float3 xlv_TEXCOORD0 :TEXCOORD0;
          float2 xlv_TEXCOORD1 :TEXCOORD1;
          float3 xlv_TEXCOORD2 :TEXCOORD2;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float3 xlv_TEXCOORD0 :TEXCOORD0;
          float2 xlv_TEXCOORD1 :TEXCOORD1;
          float3 xlv_TEXCOORD2 :TEXCOORD2;
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
          float3x3 tmpvar_2;
          tmpvar_2[0] = conv_mxt4x4_0(unity_WorldToObject).xyz;
          tmpvar_2[1] = conv_mxt4x4_1(unity_WorldToObject).xyz;
          tmpvar_2[2] = conv_mxt4x4_2(unity_WorldToObject).xyz;
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_1));
          out_v.xlv_TEXCOORD0 = mul(in_v.normal, tmpvar_2);
          out_v.xlv_TEXCOORD1 = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          out_v.xlv_TEXCOORD2 = (_WorldSpaceCameraPos - mul(unity_ObjectToWorld, in_v.vertex).xyz);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float3 rimColor_1;
          float4 color_2;
          float3 worldNormal_3;
          float3 tmpvar_4;
          tmpvar_4 = normalize(in_f.xlv_TEXCOORD0);
          worldNormal_3 = tmpvar_4;
          float4 tmpvar_5;
          tmpvar_5 = tex2D(_MainTex, in_f.xlv_TEXCOORD1);
          color_2 = tmpvar_5;
          float tmpvar_6;
          tmpvar_6 = (1 - max(0, dot(normalize(in_f.xlv_TEXCOORD2), worldNormal_3)));
          rimColor_1 = float3(0, 0, 0);
          if((_RimPower>0))
          {
              float3 tmpvar_7;
              tmpvar_7 = ((_RimColor * pow(tmpvar_6, (1 / _RimPower))) * 3).xyz.xyz;
              rimColor_1 = tmpvar_7;
          }
          color_2.xyz = float3(((tmpvar_5.xyz + _TextureColor.xyz) + rimColor_1));
          out_f.color = color_2;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Diffuse"
}
