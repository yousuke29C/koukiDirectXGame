#include "BasicShaderHeader.hlsli"

//[maxvertexcount(1)]
//void main(
//	point VSOutput input[1]:SV_POSITION,
//	//�����X�g���[��
//	inout PointStream< GSOutput > output
//)
//{
//	GSOutput element;
//	//���_���
//	element.normal = input[0].normal;
//	element.uv = input[0].uv;
//	element.svpos = input[0].svpos;
//	output.Append(element);
//}

//�l�p�`�̒��_��
static const uint vnum = 4;

//�Z���^�[����̃I�t�Z�b�g
static const float4 offset_array[vnum] =
{
	float4(-0.5f,-0.5f,0,0), //����
	float4(-0.5f,+0.5f,0,0), //����
	float4(+0.5f,-0.5f,0,0), //�E��
	float4(+0.5f,+0.5f,0,0)  //�E��
};

//���オ0,0 �E����1,1
static const float2 uv_array[vnum] =
{
	float2(0,1), //����
	float2(0,0), //����
	float2(1,1), //�E��
	float2(1,0)  //�E��
};
//�_�̓��͂���l�p�`���o��
[maxvertexcount(vnum)]
void main(
	point VSOutput input[1]:SV_POSITION,
	inout TriangleStream< GSOutput > output
)
{
	GSOutput element;
	//4�_���܂킷
	for (uint i = 0; i < vnum; i++) {
		//���[���h���W�X�y�[�X�ŁA���炷
		element.svpos =
			input[0].pos
			+ offset_array[i];
		//�r���[�ϊ��A�ˉe�ϊ�
		element.svpos = mul(mat, element.svpos);
		element.uv = uv_array[i];
		output.Append(element);
	}
}