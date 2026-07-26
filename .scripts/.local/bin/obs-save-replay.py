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
        cl.save_replay_buffer()
    except Exception as e:
        notify("OBS Replay", f"Failed to save replay: {e}", urgency="critical")
        return

    notify("OBS Replay", "Replay saved")


if __name__ == "__main__":
    main()
