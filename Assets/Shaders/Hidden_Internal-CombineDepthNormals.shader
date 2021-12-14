Shader "Hidden/Internal-CombineDepthNormals"
{
  Properties
  {
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
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _CameraNormalsTexture_ST;
      //uniform float4 _ZBufferParams;
      //uniform float4x4 unity_WorldToCamera;
      uniform sampler2D _CameraDepthTexture;
      uniform sampler2D _CameraNormalsTexture;
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
          out_v.xlv_TEXCOORD0 = TRANSFORM_TEX(in_v.texcoord.xy, _CameraNormalsTexture);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          float3 n_2;
          float3 tmpvar_3;
          tmpvar_3 = ((tex2D(_CameraNormalsTexture, in_f.xlv_TEXCOORD0) * 2) - 1).xyz.xyz;
          n_2 = tmpvar_3;
          float tmpvar_4;
          tmpvar_4 = (1 / ((_ZBufferParams.x * tex2D(_CameraDepthTexture, in_f.xlv_TEXCOORD0).x) + _ZBufferParams.y));
          float3x3 tmpvar_5;
          tmpvar_5[0] = conv_mxt4x4_0(unity_WorldToCamera).xyz;
          tmpvar_5[1] = conv_mxt4x4_1(unity_WorldToCamera).xyz;
          tmpvar_5[2] = conv_mxt4x4_2(unity_WorldToCamera).xyz;
          n_2 = mul(tmpvar_5, n_2);
          n_2.z = (-n_2.z);
          float4 tmpvar_6;
          if((tmpvar_4<0.9999846))
          {
              float4 enc_7;
              float2 enc_8;
              enc_8 = (n_2.xy / (n_2.z + 1));
              enc_8 = (enc_8 / 1.7777);
              enc_8 = ((enc_8 * 0.5) + 0.5);
              enc_7.xy = float2(enc_8);
              float2 enc_9;
              float2 tmpvar_10;
              tmpvar_10 = frac((float2(1, 255) * tmpvar_4));
              enc_9.y = tmpvar_10.y;
              enc_9.x = (tmpvar_10.x - (tmpvar_10.y * 0.003921569));
              enc_7.zw = enc_9;
              tmpvar_6 = enc_7;
          }
          else
          {
              tmpvar_6 = float4(0.5, 0.5, 1, 1);
          }
          tmpvar_1 = tmpvar_6;
          out_f.color = tmpvar_1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
