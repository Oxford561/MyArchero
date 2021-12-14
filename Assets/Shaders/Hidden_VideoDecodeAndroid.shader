// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/VideoDecodeAndroid"
{
  Properties
  {
  }
  SubShader
  {
    Tags
    { 
    }
    Pass // ind: 1, name: RGBAEXTERNAL_TO_RGBA
    {
      Name "RGBAEXTERNAL_TO_RGBA"
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
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      #define conv_mxt3x3_0(mat4x4) float3(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x)
      #define conv_mxt3x3_1(mat4x4) float3(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y)
      #define conv_mxt3x3_2(mat4x4) float3(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z)
      
      
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixVP;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixInvV;
      //uniform float4x4 UNITY_MATRIX_P;
      //uniform float4 _Time;
      //uniform float4 _SinTime;
      //uniform float4 _CosTime;
      //uniform float4 _ProjectionParams;
      //uniform float4 _ScreenParams;
      //uniform float3 _WorldSpaceCameraPos;
      //uniform float4 _WorldSpaceLightPos0;
      //uniform float4 _LightPositionRange;
      uniform float4 _MainTex_ST;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float3 normal :NORMAL;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 vertex :SV_POSITION;
          //return TEXCOORD[1];
      };
      
      struct v2f
      {
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float3x3 transpose(float3x3 mtx)
      {
          float3 c0 = conv_mxt3x3_0(mtx);
          float3 c1 = conv_mxt3x3_1(mtx);
          float3 c2 = conv_mxt3x3_2(mtx);
          return float3x3(float3(c0.x, c1.x, c2.x), float3(c0.y, c1.y, c2.y), float3(c0.z, c1.z, c2.z));
      }
      
      float4x4 transpose(float4x4 mtx)
      {
          float4 c0 = conv_mxt4x4_0(mtx);
          float4 c1 = conv_mxt4x4_1(mtx);
          float4 c2 = conv_mxt4x4_2(mtx);
          float4 c3 = conv_mxt4x4_3(mtx);
          return float4x4(float4(c0.x, c1.x, c2.x, c3.x), float4(c0.y, c1.y, c2.y, c3.y), float4(c0.z, c1.z, c2.z, c3.z), float4(c0.w, c1.w, c2.w, c3.w));
      }
      
      float saturate(float x)
      {
          return max(0, min(1, x));
      }
      
      float2 ParallaxOffset(float h, float height, float3 viewDir )
      {
          h = ((h * height) - (height / 2));
          float3 v = normalize(viewDir);
          v.z = (v.z + 0.42);
          return (h * (v.xy / v.z));
      }
      
      float Luminance(float3 c )
      {
          return dot(c, float3(0.22, 0.707, 0.071));
      }
      
      #define CODE_BLOCK_VERTEX
      float3 WorldSpaceLightDir(float4 v )
      {
          float3 worldPos = mul(unity_ObjectToWorld, v).xyz;
          #ifndef USING_LIGHT_MULTI_COMPILE
          return (_WorldSpaceLightPos0.xyz - (worldPos * _WorldSpaceLightPos0.w));
          #else
          #ifndef USING_DIRECTIONAL_LIGHT
          return (_WorldSpaceLightPos0.xyz - worldPos);
          #else
          return _WorldSpaceLightPos0.xyz;
          #endif
          #endif
      }
      
      float3 ObjSpaceLightDir(float4 v )
      {
          float3 objSpaceLightPos = mul(unity_WorldToObject, _WorldSpaceLightPos0).xyz;
          #ifndef USING_LIGHT_MULTI_COMPILE
          return (objSpaceLightPos.xyz - (v.xyz * _WorldSpaceLightPos0.w));
          #else
          #ifndef USING_DIRECTIONAL_LIGHT
          return (objSpaceLightPos.xyz - v.xyz);
          #else
          return objSpaceLightPos.xyz;
          #endif
          #endif
      }
      
      float3 WorldSpaceViewDir(float4 v )
      {
          return (_WorldSpaceCameraPos.xyz - mul(unity_ObjectToWorld, v).xyz);
      }
      
      float3 ObjSpaceViewDir(float4 v )
      {
          float3 objSpaceCameraPos = mul(unity_WorldToObject, float4(_WorldSpaceCameraPos.xyz, 1)).xyz;
          return (objSpaceCameraPos - v.xyz);
      }
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          out_v.textureCoord = TRANSFORM_TEX_ST(in_v.texcoord, _MainTex_ST);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 AdjustForColorSpace(float4 color)
      {
          #ifdef UNITY_COLORSPACE_GAMMA
          return color;
          #else
          float3 sRGB = color.rgb;
          return float4((sRGB * ((sRGB * ((sRGB * 0.305306011) + 0.682171111)) + 0.012522878)), color.a);
          #endif
      }
      
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          out_f.color = AdjustForColorSpace(tex2D(_MainTex, in_f.textureCoord));
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: RGBASPLITEXTERNAL_TO_RGBA
    {
      Name "RGBASPLITEXTERNAL_TO_RGBA"
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
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      #define conv_mxt3x3_0(mat4x4) float3(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x)
      #define conv_mxt3x3_1(mat4x4) float3(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y)
      #define conv_mxt3x3_2(mat4x4) float3(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z)
      
      
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixVP;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixInvV;
      //uniform float4x4 UNITY_MATRIX_P;
      //uniform float4 _Time;
      //uniform float4 _SinTime;
      //uniform float4 _CosTime;
      //uniform float4 _ProjectionParams;
      //uniform float4 _ScreenParams;
      //uniform float3 _WorldSpaceCameraPos;
      //uniform float4 _WorldSpaceLightPos0;
      //uniform float4 _LightPositionRange;
      uniform float4 _MainTex_ST;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION;
          float3 normal :NORMAL;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 vertex :SV_POSITION;
          //return TEXCOORD[1];
      };
      
      struct v2f
      {
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float3x3 transpose(float3x3 mtx)
      {
          float3 c0 = conv_mxt3x3_0(mtx);
          float3 c1 = conv_mxt3x3_1(mtx);
          float3 c2 = conv_mxt3x3_2(mtx);
          return float3x3(float3(c0.x, c1.x, c2.x), float3(c0.y, c1.y, c2.y), float3(c0.z, c1.z, c2.z));
      }
      
      float4x4 transpose(float4x4 mtx)
      {
          float4 c0 = conv_mxt4x4_0(mtx);
          float4 c1 = conv_mxt4x4_1(mtx);
          float4 c2 = conv_mxt4x4_2(mtx);
          float4 c3 = conv_mxt4x4_3(mtx);
          return float4x4(float4(c0.x, c1.x, c2.x, c3.x), float4(c0.y, c1.y, c2.y, c3.y), float4(c0.z, c1.z, c2.z, c3.z), float4(c0.w, c1.w, c2.w, c3.w));
      }
      
      float saturate(float x)
      {
          return max(0, min(1, x));
      }
      
      float2 ParallaxOffset(float h, float height, float3 viewDir )
      {
          h = ((h * height) - (height / 2));
          float3 v = normalize(viewDir);
          v.z = (v.z + 0.42);
          return (h * (v.xy / v.z));
      }
      
      float Luminance(float3 c )
      {
          return dot(c, float3(0.22, 0.707, 0.071));
      }
      
      #define CODE_BLOCK_VERTEX
      float3 WorldSpaceLightDir(float4 v )
      {
          float3 worldPos = mul(unity_ObjectToWorld, v).xyz;
          #ifndef USING_LIGHT_MULTI_COMPILE
          return (_WorldSpaceLightPos0.xyz - (worldPos * _WorldSpaceLightPos0.w));
          #else
          #ifndef USING_DIRECTIONAL_LIGHT
          return (_WorldSpaceLightPos0.xyz - worldPos);
          #else
          return _WorldSpaceLightPos0.xyz;
          #endif
          #endif
      }
      
      float3 ObjSpaceLightDir(float4 v )
      {
          float3 objSpaceLightPos = mul(unity_WorldToObject, _WorldSpaceLightPos0).xyz;
          #ifndef USING_LIGHT_MULTI_COMPILE
          return (objSpaceLightPos.xyz - (v.xyz * _WorldSpaceLightPos0.w));
          #else
          #ifndef USING_DIRECTIONAL_LIGHT
          return (objSpaceLightPos.xyz - v.xyz);
          #else
          return objSpaceLightPos.xyz;
          #endif
          #endif
      }
      
      float3 WorldSpaceViewDir(float4 v )
      {
          return (_WorldSpaceCameraPos.xyz - mul(unity_ObjectToWorld, v).xyz);
      }
      
      float3 ObjSpaceViewDir(float4 v )
      {
          float3 objSpaceCameraPos = mul(unity_WorldToObject, float4(_WorldSpaceCameraPos.xyz, 1)).xyz;
          return (objSpaceCameraPos - v.xyz);
      }
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          out_v.textureCoordSplit.xz = (float2(((0.5 * in_v.texcoord.x) * _MainTex_ST.x), (in_v.texcoord.y * _MainTex_ST.y)) + _MainTex_ST.zw);
          out_v.textureCoordSplit.y = (out_v.textureCoordSplit.x + (0.5 * _MainTex_ST.x));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 AdjustForColorSpace(float4 color)
      {
          #ifdef UNITY_COLORSPACE_GAMMA
          return color;
          #else
          float3 sRGB = color.rgb;
          return float4((sRGB * ((sRGB * ((sRGB * 0.305306011) + 0.682171111)) + 0.012522878)), color.a);
          #endif
      }
      
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          out_f.color.rgb = AdjustForColorSpace(tex2D(_MainTex, in_f.textureCoordSplit.xz)).rgb;
          out_f.color.a = tex2D(_MainTex, in_f.textureCoordSplit.yz).g;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
