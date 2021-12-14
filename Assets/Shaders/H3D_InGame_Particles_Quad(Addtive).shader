Shader "H3D/InGame/Particles/Quad(Addtive)"
{
  Properties
  {
    _MainTex ("Base texture", 2D) = "white" {}
    _MaskTex ("Mask(Alpha)", 2D) = "white" {}
    _Color ("Color", Color) = (1,1,1,1)
    _Angle ("Angle", float) = 0
    _RotateSpeed ("RotateSpeed", float) = 0
  }
  SubShader
  {
    Tags
    { 
      "DisableBatching" = "true"
      "IGNOREPROJECTOR" = "true"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    LOD 200
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "DisableBatching" = "true"
        "IGNOREPROJECTOR" = "true"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      LOD 200
      ZWrite Off
      Cull Off
      Blend SrcAlpha One
      ColorMask RGB
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _Time;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 UNITY_MATRIX_P;
      //uniform float4x4 unity_MatrixV;
      uniform float4 _MainTex_ST;
      uniform float _Angle;
      uniform float _RotateSpeed;
      uniform sampler2D _MainTex;
      uniform sampler2D _MaskTex;
      uniform float4 _Color;
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
      
      //float4x4 unity_MatrixMV;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          unity_MatrixMV = mul(unity_MatrixV, unity_ObjectToWorld);
          float4 tmpvar_1;
          tmpvar_1 = in_v.vertex;
          float4 npos_2;
          float angle_3;
          float tmpvar_4;
          tmpvar_4 = ((_Angle + (_RotateSpeed * _Time.y)) / 360);
          float tmpvar_5;
          tmpvar_5 = (frac(abs(tmpvar_4)) * 360);
          float tmpvar_6;
          if((tmpvar_4>=0))
          {
              tmpvar_6 = tmpvar_5;
          }
          else
          {
              tmpvar_6 = (-tmpvar_5);
          }
          angle_3 = ((tmpvar_6 / 360) * 6.283185);
          float tmpvar_7;
          tmpvar_7 = cos(angle_3);
          float tmpvar_8;
          tmpvar_8 = sin(angle_3);
          float2 tmpvar_9;
          tmpvar_9.x = tmpvar_7;
          tmpvar_9.y = (-tmpvar_8);
          float2 tmpvar_10;
          tmpvar_10.x = tmpvar_8;
          tmpvar_10.y = tmpvar_7;
          float3 tmpvar_11;
          tmpvar_11.x = conv_mxt4x4_0(unity_ObjectToWorld).x;
          tmpvar_11.y = conv_mxt4x4_0(unity_ObjectToWorld).y.x;
          tmpvar_11.z = conv_mxt4x4_0(unity_ObjectToWorld).z.x;
          float3 tmpvar_12;
          tmpvar_12.x = conv_mxt4x4_1(unity_ObjectToWorld).x;
          tmpvar_12.y = conv_mxt4x4_1(unity_ObjectToWorld).y.x;
          tmpvar_12.z = conv_mxt4x4_1(unity_ObjectToWorld).z.x;
          npos_2.w = 0;
          npos_2.x = dot(normalize(tmpvar_9), in_v.vertex.xy);
          npos_2.y = dot(normalize(tmpvar_10), in_v.vertex.xy);
          npos_2.z = tmpvar_1.z;
          float4 tmpvar_13;
          tmpvar_13.zw = float2(1, 1);
          tmpvar_13.x = sqrt(dot(tmpvar_11, tmpvar_11));
          tmpvar_13.y = sqrt(dot(tmpvar_12, tmpvar_12));
          out_v.vertex = mul(UNITY_MATRIX_P, ((npos_2 * tmpvar_13) + mul(unity_MatrixMV, float4(0, 0, 0, 1))));
          out_v.xlv_TEXCOORD0 = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 mc_1;
          mc_1.xyz = float3((tex2D(_MainTex, in_f.xlv_TEXCOORD0).xyz * _Color.xyz));
          mc_1.w = (tex2D(_MaskTex, in_f.xlv_TEXCOORD0).x * _Color.w).x;
          out_f.color = mc_1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
