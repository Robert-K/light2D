using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(Light2DRenderer))]
public class Light2DRendererEditor : Editor
{
    private Light2DRenderer renderer;

    private float sdfBorder;
    private int samples;
    private Color ambientColor;
    private float maxBrightness;
    private bool raycast;

    private Camera camera;

    private void OnEnable()
    {
        renderer = (Light2DRenderer)target;

        sdfBorder = renderer.sdfBorder;
        samples = renderer.samples;
        ambientColor = renderer.ambientColor;
        maxBrightness = renderer.maxBrightness;
        raycast = renderer.raycast;

        camera = renderer.GetComponent<Camera>();
    }

    public override void OnInspectorGUI()
    {
        EditorGUI.BeginChangeCheck();
        sdfBorder = EditorGUILayout.Slider("SDF Border", sdfBorder, 0, 1);
        if (EditorGUI.EndChangeCheck())
        {
            renderer.sdfBorder = sdfBorder;
            UnityEditorInternal.InternalEditorUtility.RepaintAllViews();
        }

        EditorGUI.BeginChangeCheck();
        samples = EditorGUILayout.IntSlider("Samples", samples, 0, 1024);
        if (EditorGUI.EndChangeCheck())
        {
            renderer.samples = samples;
            UnityEditorInternal.InternalEditorUtility.RepaintAllViews();
        }

        EditorGUI.BeginChangeCheck();
        ambientColor = EditorGUILayout.ColorField("Ambient Light", ambientColor);
        if (EditorGUI.EndChangeCheck())
        {
            renderer.ambientColor = ambientColor;
            UnityEditorInternal.InternalEditorUtility.RepaintAllViews();
        }

        EditorGUI.BeginChangeCheck();
        maxBrightness = EditorGUILayout.Slider("max Brightness", maxBrightness, 0, 100);
        if (EditorGUI.EndChangeCheck())
        {
            renderer.maxBrightness = maxBrightness;
            UnityEditorInternal.InternalEditorUtility.RepaintAllViews();
        }
        EditorGUI.BeginChangeCheck();
        raycast = EditorGUILayout.Toggle("Raycast", raycast);
        if (EditorGUI.EndChangeCheck())
        {
            renderer.raycast = raycast;
            UnityEditorInternal.InternalEditorUtility.RepaintAllViews();
        }
    }

    private void OnSceneGUI()
    {
        float height = (camera.orthographicSize * (1 - sdfBorder)) * 2;
        float width = height * camera.aspect;
        Handles.DrawSolidRectangleWithOutline(new Rect(camera.transform.position.x - width / 2, camera.transform.position.y - height / 2, width, height), new Color(0, 0, 0, 0), Color.red);
    }
}
