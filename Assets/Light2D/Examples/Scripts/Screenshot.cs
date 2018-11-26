using UnityEngine;

public class Screenshot : MonoBehaviour
{
    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space))
        {
            ScreenCapture.CaptureScreenshot("Screenshots/" + System.DateTime.Now.ToString("HHmmss")+".jpg");
        }
    }
}
