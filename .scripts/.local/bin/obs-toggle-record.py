#!/home/tobi6hana/.local/share/obs-hotkeys-venv/bin/python
import subprocess
import obsws_python as obs


def notify(title, message, urgency="normal"):
    subprocess.run(
        ["notify-send", "-u", urgency, "-a", "OBS", title, message],
        check=False,
    )


def main():
    try:
        cl = obs.ReqClient(host='localhost', port=4455, password='nNxSXRmpCeV9KqAd', timeout=3)
        cl.toggle_record()
        # Ask OBS for the actual current state rather than trusting the
        # toggle response, so the message always matches reality.
        status = cl.get_record_status()
        is_recording = getattr(status, "output_active", None)
    except Exception as e:
        notify("OBS Recording", f"Failed to toggle recording: {e}", urgency="critical")
        return

    if is_recording is True:
        notify("OBS Recording", "Finished recording")
    elif is_recording is False:
        notify("OBS Recording", "Started recording")
    else:
        notify("OBS Recording", "Toggled recording")


if __name__ == "__main__":
    main()
