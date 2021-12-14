Shader "Hidden/ConvertTexture"
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
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform float _faceIndex;
      uniform samplerCUBE _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float3 xlv_TEXCOORD0 :TEXCOORD0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float3 xlv_TEXCOORD0 :TEXCOORD0;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float3 faceU[6];
      float3 faceV[6];
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          faceU[0] = float3(0, 0, (-1));
          faceU[1] = float3(0, 0, 1);
          faceU[2] = float3(1, 0, 0);
          faceU[3] = float3(1, 0, 0);
          faceU[4] = float3(1, 0, 0);
          faceU[5] = float3(-1, 0, 0);
          faceV[0] = float3(0, (-1), 0);
          faceV[1] = float3(0, (-1), 0);
          faceV[2] = float3(0, 0, 1);
          faceV[3] = float3(0, 0, (-1));
          faceV[4] = float3(0, (-1), 0);
          faceV[5] = float3(0, (-1), 0);
          float2 uv_1;
          float4 tmpvar_2;
          tmpvar_2.w = 1;
          tmpvar_2.xyz = float3(in_v.vertex.xyz);
          uv_1 = ((TRANSFORM_TEX(in_v.texcoord.xy, _MainTex) * 2) - 1);
          int tmpvar_3;
          tmpvar_3 = int(_faceIndex);
          float3 tmpvar_4;
          float _tmp_dvx_72 = faceU[tmpvar_3];
          tmpvar_4 = float3(_tmp_dvx_72, _tmp_dvx_72, _tmp_dvx_72);
          float3 tmpvar_5;
          float _tmp_dvx_73 = faceV[tmpvar_3];
          tmpvar_5 = float3(_tmp_dvx_73, _tmp_dvx_73, _tmp_dvx_73);
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_2));
          out_v.xlv_TEXCOORD0 = ((((tmpvar_5.yzx * tmpvar_4.zxy) - (tmpvar_5.zxy * tmpvar_4.yzx)) + (uv_1.x * tmpvar_4)) + (uv_1.y * tmpvar_5));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          tmpvar_1 = texCUBE(_MainTex, in_f.xlv_TEXCOORD0);
          out_f.color = tmpvar_1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
