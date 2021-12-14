using UnityEngine;
using System;


public struct JoyData
{
    public string name;

    public Vector3 direction;

    public Vector3 _moveDirection;

    public float angle;

    public float length;

    public int type;

    public string action;

    public Vector3 MoveDirection
    {
        get
        {
            if (_moveDirection != Vector3.zero)
            {
                return _moveDirection;
            }
            else
            {
                return direction;
            }
        }
    }

    public void Revert()
    {
        direction *= -1f;
        angle = (angle + 180f) % 360f;
    }

    public void UpdateDirectionByAngle(float angle)
    {
        this.angle = angle;
        direction.x = Mathf.Sin(angle * (float)Math.PI / 180f);
        direction.y = Mathf.Cos(angle * (float)Math.PI / 180f);
    }
}