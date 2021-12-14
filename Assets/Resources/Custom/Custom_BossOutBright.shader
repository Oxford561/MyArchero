Shader "Custom/BossOutBright"
{
  Properties
  {
    _MainColor ("【主颜色】Main Color", Color) = (0.5,0.5,0.5,1)
    _TextureDiffuse ("【漫反射纹理】Texture Diffuse", 2D) = "white" {}
    _RimColor ("【边缘发光颜色】Rim Color", Color) = (0.5,0.5,0.5,1)
    _RimPower ("【边缘发光强度】Rim Power", Range(0, 36)) = 0.1
    _RimIntensity ("【边缘发光强度系数】Rim Intensity", Range(0, 100)) = 3
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Opaque"
    }
    Pass // ind: 1, name: FORWARDBASE
    {
      Name "FORWARDBASE"
      Tags
      { 
        "LIGHTMODE" = "FORWARDBASE"
        "RenderType" = "Opaque"
      }
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixVP;
      //uniform float3 _WorldSpaceCameraPos;
      //uniform float4 _WorldSpaceLightPos0;
      //uniform float4 glstate_lightmodel_ambient;
      uniform float4 _LightColor0;
      uniform float4 _MainColor;
      uniform sampler2D _TextureDiffuse;
      uniform float4 _TextureDiffuse_ST;
      uniform float4 _RimColor;
      uniform float _RimPower;
      uniform float _RimIntensity;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float3 normal :NORMAL;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float3 xlv_NORMAL :NORMAL;
          float4 xlv_TEXCOORD1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 xlv_TEXCOORD0 :TEXCOORD0;
          float3 xlv_NORMAL :NORMAL;
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
          tmpvar_1.w = 0;
          tmpvar_1.xyz = float3(in_v.normal);
          float4 tmpvar_2;
          tmpvar_2.w = 1;
          tmpvar_2.xyz = float3(in_v.vertex.xyz);
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_2));
          out_v.xlv_TEXCOORD0 = in_v.texcoord;
          out_v.xlv_NORMAL = mul(tmpvar_1, unity_WorldToObject).xyz;
          out_v.xlv_TEXCOORD1 = mul(unity_ObjectToWorld, in_v.vertex);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          float Rim_2;
          float tmpvar_3;
          tmpvar_3 = (1 - max(0, dot(in_f.xlv_NORMAL, normalize((_WorldSpaceCameraPos - in_f.xlv_TEXCOORD1.xyz)))));
          Rim_2 = tmpvar_3;
          float4 tmpvar_4;
          float2 P_5;
          P_5 = TRANSFORM_TEX(in_f.xlv_TEXCOORD0.xy, _TextureDiffuse);
          tmpvar_4 = tex2D(_TextureDiffuse, P_5);
          float4 tmpvar_6;
          tmpvar_6.w = 1;
          tmpvar_6.xyz = float3(((((max(0, dot(normalize(in_f.xlv_NORMAL), normalize(_WorldSpaceLightPos0.xyz))) * _LightColor0.xyz) + (glstate_lightmodel_ambient * 2).xyz) * (tmpvar_4.xyz * _MainColor.xyz)) + ((_RimColor.xyz * pow(Rim_2, _RimPower)) * _RimIntensity)));
          tmpvar_1 = tmpvar_6;
          out_f.color = tmpvar_1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Diffuse"
}
