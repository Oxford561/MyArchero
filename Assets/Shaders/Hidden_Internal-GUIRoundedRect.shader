Shader "Hidden/Internal-GUIRoundedRect"
{
  Properties
  {
    _MainTex ("Texture", any) = "white" {}
    _SrcBlend ("SrcBlend", float) = 5
    _DstBlend ("DstBlend", float) = 10
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
      Blend Zero Zero, One OneMinusSrcAlpha
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform float4x4 unity_GUIClipTextureMatrix;
      uniform sampler2D _MainTex;
      uniform sampler2D _GUIClipTexture;
      uniform int _ManualTex2SRGB;
      uniform int _SrcBlend;
      uniform float _CornerRadiuses[4];
      uniform float _BorderWidths[4];
      uniform float _Rect[4];
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 color :COLOR;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 xlv_COLOR :COLOR;
          float2 xlv_TEXCOORD0 :TEXCOORD0;
          float2 xlv_TEXCOORD1 :TEXCOORD1;
          float4 xlv_TEXCOORD2 :TEXCOORD2;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 xlv_COLOR :COLOR;
          float2 xlv_TEXCOORD0 :TEXCOORD0;
          float2 xlv_TEXCOORD1 :TEXCOORD1;
          float4 xlv_TEXCOORD2 :TEXCOORD2;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          float4 tmpvar_1;
          tmpvar_1 = in_v.vertex;
          float4 tmpvar_2;
          tmpvar_2.w = 1;
          tmpvar_2.xyz = float3(tmpvar_1.xyz);
          float4 tmpvar_3;
          tmpvar_3.w = 1;
          tmpvar_3.xyz = float3(tmpvar_1.xyz);
          float4 tmpvar_4;
          tmpvar_4.zw = float2(0, 1);
          tmpvar_4.xy = mul(unity_MatrixV, mul(unity_ObjectToWorld, tmpvar_2)).xy.xy;
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_3));
          out_v.xlv_COLOR = in_v.color;
          out_v.xlv_TEXCOORD0 = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          out_v.xlv_TEXCOORD1 = mul(unity_GUIClipTextureMatrix, tmpvar_4).xy;
          out_v.xlv_TEXCOORD2 = tmpvar_1;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          float clipAlpha_2;
          float borderAlpha_3;
          float cornerAlpha_4;
          float2 center_5;
          int radiusIndex_6;
          float bw2_7;
          float bw1_8;
          float4 col_9;
          float tmpvar_10;
          tmpvar_10 = (1 / abs(ddx(in_f.xlv_TEXCOORD2.x)));
          float4 tmpvar_11;
          tmpvar_11 = tex2D(_MainTex, in_f.xlv_TEXCOORD0);
          col_9 = tmpvar_11;
          if(_ManualTex2SRGB)
          {
              col_9.xyz = float3(max(((1.055 * pow(max(col_9.xyz, float3(0, 0, 0)), float3(0.4166667, 0.4166667, 0.4166667))) - 0.055), float3(0, 0, 0)));
          }
          col_9 = (col_9 * in_f.xlv_COLOR);
          int tmpvar_12;
          if((((in_f.xlv_TEXCOORD2.x - _Rect[0]) - (_Rect[2] / 2))<=0))
          {
              tmpvar_12 = 1;
          }
          else
          {
              tmpvar_12 = 0;
          }
          int tmpvar_13;
          if((((in_f.xlv_TEXCOORD2.y - _Rect[1]) - (_Rect[3] / 2))<=0))
          {
              tmpvar_13 = 1;
          }
          else
          {
              tmpvar_13 = 0;
          }
          bw1_8 = _BorderWidths[0];
          bw2_7 = _BorderWidths[1];
          radiusIndex_6 = 0;
          if(tmpvar_12)
          {
              int tmpvar_14;
              if(tmpvar_13)
              {
                  tmpvar_14 = 0;
              }
              else
              {
                  tmpvar_14 = 3;
              }
              radiusIndex_6 = tmpvar_14;
          }
          else
          {
              int tmpvar_15;
              if(tmpvar_13)
              {
                  tmpvar_15 = 1;
              }
              else
              {
                  tmpvar_15 = 2;
              }
              radiusIndex_6 = tmpvar_15;
          }
          float tmpvar_16;
          tmpvar_16 = _CornerRadiuses[radiusIndex_6];
          float2 tmpvar_17;
          tmpvar_17.x = (_Rect[0] + tmpvar_16);
          tmpvar_17.y = (_Rect[1] + tmpvar_16);
          center_5 = tmpvar_17;
          if(!tmpvar_12)
          {
              center_5.x = ((_Rect[0] + _Rect[2]) - tmpvar_16);
              bw1_8 = _BorderWidths[2];
          }
          if(!tmpvar_13)
          {
              center_5.y = ((_Rect[1] + _Rect[3]) - tmpvar_16);
              bw2_7 = _BorderWidths[3];
          }
          int tmpvar_18;
          if(tmpvar_12)
          {
              if((in_f.xlv_TEXCOORD2.x<=center_5.x))
              {
                  tmpvar_18 = 1;
              }
              else
              {
                  tmpvar_18 = 0;
              }
          }
          if((in_f.xlv_TEXCOORD2.x>=center_5.x))
          {
              tmpvar_18 = 1;
          }
          else
          {
              tmpvar_18 = 0;
          }
          int tmpvar_19;
          if(tmpvar_18)
          {
              int tmpvar_20;
              if(tmpvar_13)
              {
                  if((in_f.xlv_TEXCOORD2.y<=center_5.y))
                  {
                      tmpvar_20 = 1;
                  }
                  else
                  {
                      tmpvar_20 = 0;
                  }
              }
              if((in_f.xlv_TEXCOORD2.y>=center_5.y))
              {
                  tmpvar_20 = 1;
              }
              else
              {
                  tmpvar_20 = 0;
              }
              tmpvar_19 = tmpvar_20;
          }
          else
          {
              tmpvar_19 = int(0);
          }
          float tmpvar_21;
          if(tmpvar_19)
          {
              float rawDist_22;
              float2 v_23;
              int tmpvar_24;
              if(((bw1_8>0) || (bw2_7>0)))
              {
                  tmpvar_24 = 1;
              }
              else
              {
                  tmpvar_24 = 0;
              }
              float2 tmpvar_25;
              tmpvar_25 = (in_f.xlv_TEXCOORD2.xy - center_5);
              v_23 = tmpvar_25;
              float tmpvar_26;
              tmpvar_26 = ((sqrt(dot(tmpvar_25, tmpvar_25)) - tmpvar_16) * tmpvar_10);
              float tmpvar_27;
              if(tmpvar_24)
              {
                  float tmpvar_28;
                  tmpvar_28 = clamp((0.5 + tmpvar_26), 0, 1);
                  tmpvar_27 = tmpvar_28;
              }
              else
              {
                  tmpvar_27 = 0;
              }
              float tmpvar_29;
              tmpvar_29 = (tmpvar_16 - bw1_8);
              float tmpvar_30;
              tmpvar_30 = (tmpvar_16 - bw2_7);
              v_23.y = (tmpvar_25.y * (tmpvar_29 / tmpvar_30));
              float tmpvar_31;
              tmpvar_31 = ((sqrt(dot(v_23, v_23)) - tmpvar_29) * tmpvar_10);
              rawDist_22 = tmpvar_31;
              float tmpvar_32;
              tmpvar_32 = clamp((rawDist_22 + 0.5), 0, 1);
              float tmpvar_33;
              if(tmpvar_24)
              {
                  float tmpvar_34;
                  if(((tmpvar_29>0) && (tmpvar_30>0)))
                  {
                      tmpvar_34 = tmpvar_32;
                  }
                  else
                  {
                      tmpvar_34 = 1;
                  }
                  tmpvar_33 = tmpvar_34;
              }
              else
              {
                  tmpvar_33 = 0;
              }
              float tmpvar_35;
              if((tmpvar_27==0))
              {
                  tmpvar_35 = tmpvar_33;
              }
              else
              {
                  tmpvar_35 = (1 - tmpvar_27);
              }
              tmpvar_21 = tmpvar_35;
          }
          else
          {
              tmpvar_21 = 1;
          }
          cornerAlpha_4 = tmpvar_21;
          col_9.w = (col_9.w * cornerAlpha_4);
          float4 tmpvar_36;
          tmpvar_36.x = (_Rect[0] + _BorderWidths[0]);
          tmpvar_36.y = (_Rect[1] + _BorderWidths[1]);
          tmpvar_36.z = (_Rect[2] - (_BorderWidths[0] + _BorderWidths[2]));
          tmpvar_36.w = (_Rect[3] - (_BorderWidths[1] + _BorderWidths[3]));
          int tmpvar_37;
      }
      
      
      ENDCG
      
    } // end phase
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
      Blend Zero Zero
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform float4x4 unity_GUIClipTextureMatrix;
      uniform sampler2D _MainTex;
      uniform sampler2D _GUIClipTexture;
      uniform int _ManualTex2SRGB;
      uniform int _SrcBlend;
      uniform float _CornerRadiuses[4];
      uniform float _BorderWidths[4];
      uniform float _Rect[4];
      struct appdata_t
      {
          float4 vertex :POSITION;
          float4 color :COLOR;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 xlv_COLOR :COLOR;
          float2 xlv_TEXCOORD0 :TEXCOORD0;
          float2 xlv_TEXCOORD1 :TEXCOORD1;
          float4 xlv_TEXCOORD2 :TEXCOORD2;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 xlv_COLOR :COLOR;
          float2 xlv_TEXCOORD0 :TEXCOORD0;
          float2 xlv_TEXCOORD1 :TEXCOORD1;
          float4 xlv_TEXCOORD2 :TEXCOORD2;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          float4 tmpvar_1;
          tmpvar_1 = in_v.vertex;
          float4 tmpvar_2;
          tmpvar_2.w = 1;
          tmpvar_2.xyz = float3(tmpvar_1.xyz);
          float4 tmpvar_3;
          tmpvar_3.w = 1;
          tmpvar_3.xyz = float3(tmpvar_1.xyz);
          float4 tmpvar_4;
          tmpvar_4.zw = float2(0, 1);
          tmpvar_4.xy = mul(unity_MatrixV, mul(unity_ObjectToWorld, tmpvar_2)).xy.xy;
          out_v.vertex = mul(unity_MatrixVP, mul(unity_ObjectToWorld, tmpvar_3));
          out_v.xlv_COLOR = in_v.color;
          out_v.xlv_TEXCOORD0 = TRANSFORM_TEX(in_v.texcoord.xy, _MainTex);
          out_v.xlv_TEXCOORD1 = mul(unity_GUIClipTextureMatrix, tmpvar_4).xy;
          out_v.xlv_TEXCOORD2 = tmpvar_1;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 tmpvar_1;
          float clipAlpha_2;
          float borderAlpha_3;
          float cornerAlpha_4;
          float2 center_5;
          int radiusIndex_6;
          float bw2_7;
          float bw1_8;
          float4 col_9;
          float tmpvar_10;
          tmpvar_10 = (1 / abs(ddx(in_f.xlv_TEXCOORD2.x)));
          float4 tmpvar_11;
          tmpvar_11 = tex2D(_MainTex, in_f.xlv_TEXCOORD0);
          col_9 = tmpvar_11;
          if(_ManualTex2SRGB)
          {
              col_9.xyz = float3(max(((1.055 * pow(max(col_9.xyz, float3(0, 0, 0)), float3(0.4166667, 0.4166667, 0.4166667))) - 0.055), float3(0, 0, 0)));
          }
          col_9 = (col_9 * in_f.xlv_COLOR);
          int tmpvar_12;
          if((((in_f.xlv_TEXCOORD2.x - _Rect[0]) - (_Rect[2] / 2))<=0))
          {
              tmpvar_12 = 1;
          }
          else
          {
              tmpvar_12 = 0;
          }
          int tmpvar_13;
          if((((in_f.xlv_TEXCOORD2.y - _Rect[1]) - (_Rect[3] / 2))<=0))
          {
              tmpvar_13 = 1;
          }
          else
          {
              tmpvar_13 = 0;
          }
          bw1_8 = _BorderWidths[0];
          bw2_7 = _BorderWidths[1];
          radiusIndex_6 = 0;
          if(tmpvar_12)
          {
              int tmpvar_14;
              if(tmpvar_13)
              {
                  tmpvar_14 = 0;
              }
              else
              {
                  tmpvar_14 = 3;
              }
              radiusIndex_6 = tmpvar_14;
          }
          else
          {
              int tmpvar_15;
              if(tmpvar_13)
              {
                  tmpvar_15 = 1;
              }
              else
              {
                  tmpvar_15 = 2;
              }
              radiusIndex_6 = tmpvar_15;
          }
          float tmpvar_16;
          tmpvar_16 = _CornerRadiuses[radiusIndex_6];
          float2 tmpvar_17;
          tmpvar_17.x = (_Rect[0] + tmpvar_16);
          tmpvar_17.y = (_Rect[1] + tmpvar_16);
          center_5 = tmpvar_17;
          if(!tmpvar_12)
          {
              center_5.x = ((_Rect[0] + _Rect[2]) - tmpvar_16);
              bw1_8 = _BorderWidths[2];
          }
          if(!tmpvar_13)
          {
              center_5.y = ((_Rect[1] + _Rect[3]) - tmpvar_16);
              bw2_7 = _BorderWidths[3];
          }
          int tmpvar_18;
          if(tmpvar_12)
          {
              if((in_f.xlv_TEXCOORD2.x<=center_5.x))
              {
                  tmpvar_18 = 1;
              }
              else
              {
                  tmpvar_18 = 0;
              }
          }
          if((in_f.xlv_TEXCOORD2.x>=center_5.x))
          {
              tmpvar_18 = 1;
          }
          else
          {
              tmpvar_18 = 0;
          }
          int tmpvar_19;
          if(tmpvar_18)
          {
              int tmpvar_20;
              if(tmpvar_13)
              {
                  if((in_f.xlv_TEXCOORD2.y<=center_5.y))
                  {
                      tmpvar_20 = 1;
                  }
                  else
                  {
                      tmpvar_20 = 0;
                  }
              }
              if((in_f.xlv_TEXCOORD2.y>=center_5.y))
              {
                  tmpvar_20 = 1;
              }
              else
              {
                  tmpvar_20 = 0;
              }
              tmpvar_19 = tmpvar_20;
          }
          else
          {
              tmpvar_19 = int(0);
          }
          float tmpvar_21;
          if(tmpvar_19)
          {
              float rawDist_22;
              float2 v_23;
              int tmpvar_24;
              if(((bw1_8>0) || (bw2_7>0)))
              {
                  tmpvar_24 = 1;
              }
              else
              {
                  tmpvar_24 = 0;
              }
              float2 tmpvar_25;
              tmpvar_25 = (in_f.xlv_TEXCOORD2.xy - center_5);
              v_23 = tmpvar_25;
              float tmpvar_26;
              tmpvar_26 = ((sqrt(dot(tmpvar_25, tmpvar_25)) - tmpvar_16) * tmpvar_10);
              float tmpvar_27;
              if(tmpvar_24)
              {
                  float tmpvar_28;
                  tmpvar_28 = clamp((0.5 + tmpvar_26), 0, 1);
                  tmpvar_27 = tmpvar_28;
              }
              else
              {
                  tmpvar_27 = 0;
              }
              float tmpvar_29;
              tmpvar_29 = (tmpvar_16 - bw1_8);
              float tmpvar_30;
              tmpvar_30 = (tmpvar_16 - bw2_7);
              v_23.y = (tmpvar_25.y * (tmpvar_29 / tmpvar_30));
              float tmpvar_31;
              tmpvar_31 = ((sqrt(dot(v_23, v_23)) - tmpvar_29) * tmpvar_10);
              rawDist_22 = tmpvar_31;
              float tmpvar_32;
              tmpvar_32 = clamp((rawDist_22 + 0.5), 0, 1);
              float tmpvar_33;
              if(tmpvar_24)
              {
                  float tmpvar_34;
                  if(((tmpvar_29>0) && (tmpvar_30>0)))
                  {
                      tmpvar_34 = tmpvar_32;
                  }
                  else
                  {
                      tmpvar_34 = 1;
                  }
                  tmpvar_33 = tmpvar_34;
              }
              else
              {
                  tmpvar_33 = 0;
              }
              float tmpvar_35;
              if((tmpvar_27==0))
              {
                  tmpvar_35 = tmpvar_33;
              }
              else
              {
                  tmpvar_35 = (1 - tmpvar_27);
              }
              tmpvar_21 = tmpvar_35;
          }
          else
          {
              tmpvar_21 = 1;
          }
          cornerAlpha_4 = tmpvar_21;
          col_9.w = (col_9.w * cornerAlpha_4);
          float4 tmpvar_36;
          tmpvar_36.x = (_Rect[0] + _BorderWidths[0]);
          tmpvar_36.y = (_Rect[1] + _BorderWidths[1]);
          tmpvar_36.z = (_Rect[2] - (_BorderWidths[0] + _BorderWidths[2]));
          tmpvar_36.w = (_Rect[3] - (_BorderWidths[1] + _BorderWidths[3]));
          int tmpvar_37;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Hidden/Internal-GUITextureClip"
}
