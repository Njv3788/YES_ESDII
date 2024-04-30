using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class FPSCounter : MonoBehaviour
{
    /*
    public TextMeshProUGUI FpsText;
    private float pollingTime = 1f;
    private float time;
    private int frameCount;
    */

    public TextMeshProUGUI FpsText;
    public float updateInterval = 0.5f; //How often should the number update

    float accum = 0.0f;
    int frames = 0;
    float timeleft;
    float fps;

    // Start is called before the first frame update
    void Start()
    {
        timeleft = updateInterval;

        
        //textStyle.fontStyle = FontStyle.Bold;
        //textStyle.normal.textColor = Color.white;
    }

    // Update is called once per frame
    void Update()
    {
        /*
        time += Time.deltaTime;
        frameCount++;

        if(time >= pollingTime)
        {
            int frameRate = Mathf.RoundToInt(frameCount / time);
            FpsText.text = frameRate.ToString() + " FPS";

            time = +pollingTime;

            frameCount = 0;
        
        }*/


        timeleft -= Time.deltaTime;
        accum += Time.timeScale / Time.deltaTime;
        ++frames;

        // Interval ended - update GUI text and start new interval
        if (timeleft <= 0.0)
        {
            // display two fractional digits (f2 format)
            fps = Mathf.Round(accum / frames);

            timeleft = updateInterval;
            accum = 0.0f;
            frames = 0;

            
            FpsText.text = fps.ToString() + " FPS";
        }

    }
}
