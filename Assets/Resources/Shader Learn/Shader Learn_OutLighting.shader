Shader "Shader Learn/OutLighting"
{
  Properties
  {
    _MainTex ("Texture(RGB)", 2D) = "grey" {}
    _Color ("Color", Color) = (0,0,0,1)
    _AtmoColor ("Atmosphere Color", Color) = (0,0.4,1,1)
    _Size ("Size", float) = 0.1
    _OutLightPow ("Falloff", float) = 5
    _OutLightStrength ("Transparency", float) = 15
  }
  SubShader
  {
    Tags
    { 
    }
    Pass // ind: 1, name: PLANEBASE
    {
      Name "PLANEBASE"
      Tags
      { 
        "LIGHTMODE" = "ALWAYS"
      }
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
      uniform sampler2D _MainTex;
      uniform float4 _Color;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float3 normal :NORMAL;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float3 xlv_TEXCOORD0 :TEXCOORD0;
          float3 xlv_TEXCOORD1 :TEXCOORD1;
          float2 xlv_TEXCOORD2 :TEXCOORD2;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 xlv_TEXCOORD2 :TEXCOORD2;
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
          out_v.xlv_TEXCOORD0 = in_v.normal;
          out_v.xlv_TEXCOORD1 = mul(unity_ObjectToWorld, in_v.vertex).xyz;
          out_v.xlv_TEXCOORD2 = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 color_1;
          float4 tmpvar_2;
          tmpvar_2 = tex2D(_MainTex, in_f.xlv_TEXCOORD2);
          color_1 = tmpvar_2;
          float4 tmpvar_3;
          tmpvar_3 = (color_1 * _Color);
          out_f.color = tmpvar_3;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: ATMOSPHEREBASE
    {
      Name "ATMOSPHEREBASE"
      Tags
      { 
        "LIGHTMODE" = "ALWAYS"
      }
      Cull Front
      Blend SrcAlpha One
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float _Size;
      //uniform float3 _WorldSpaceCameraPos;
      uniform float4 _AtmoColor;
      uniform float _OutLightPow;
      uniform float _OutLightStrength;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float3 normal :NORMAL;
      };
      
      struct OUT_Data_Vert
      {
          float3 xlv_TEXCOORD0 :TEXCOORD0;
          float3 xlv_TEXCOORD1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float3 xlv_TEXCOORD0 :TEXCOORD0;
          float3 xlv_TEXCOORD1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          float4 tmpvar_1;
          tmpvar_1.w = in_v.vertex.w;
          tmpvar_1.xyz = float3((in_v.vertex.xyz + (in_v.normal * _Size)));
          float4 tmpvar_2;
          tmpvar_2.w = 1;
          tmpvar_2.xyz = float3(tmpvar_1.xyz);
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_2));
          out_v.xlv_TEXCOORD0 = in_v.normal;
          out_v.xlv_TEXCOORD1 = mul(unity_ObjectToWorld, tmpvar_1).xyz;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 color_1;
          float3 tmpvar_2;
          tmpvar_2 = normalize(in_f.xlv_TEXCOORD0);
          float3 tmpvar_3;
          tmpvar_3 = normalize((in_f.xlv_TEXCOORD1 - _WorldSpaceCameraPos));
          color_1.xyz = float3(_AtmoColor.xyz);
          color_1.w = pow(clamp(dot(tmpvar_3, tmpvar_2), 0, 1), _OutLightPow);
          color_1.w = (color_1.w * (_OutLightStrength * dot(tmpvar_3, tmpvar_2)));
          out_f.color = color_1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Diffuse"
}
