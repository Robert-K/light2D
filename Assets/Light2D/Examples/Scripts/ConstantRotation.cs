using UnityEngine;

public class ConstantRotation : MonoBehaviour {

    public Vector3 speed;

    private void FixedUpdate()
    {
        transform.Rotate(speed * Time.fixedDeltaTime);
    }
}
