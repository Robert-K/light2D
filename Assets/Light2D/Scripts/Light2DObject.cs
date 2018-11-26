using UnityEngine;

[ExecuteInEditMode]
public class Light2DObject : MonoBehaviour {

    public Color color;

    private Renderer renderer;
    private MaterialPropertyBlock propertyBlock;

    void Awake()
    {
        propertyBlock = new MaterialPropertyBlock();
        renderer = GetComponent<Renderer>();
    }

    void Update()
    {
        renderer.GetPropertyBlock(propertyBlock);
        propertyBlock.SetColor("_Color", color);
        renderer.SetPropertyBlock(propertyBlock);
    }
}
