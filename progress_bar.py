from subprocess import PIPE, Popen, run, call
import time

previous = 0

def init():
    process = call(['bash', '-c', 'source progress_bar.sh; \
                                enable_trapping; \
                                setup_scroll_area'])

def fill(current, total, delay=None):
    percentage = int(float(current) / float(total) * 100)
    global previous
    if percentage == previous:
        pass
    else:
        run(['bash', '-c', '. progress_bar.sh; draw_progress_bar ' + str(percentage)])
        previous = percentage
    if delay: time.sleep(delay)
        

def kill():
    global previous
    run(['bash', '-c', '. progress_bar.sh; destroy_scroll_area'])
    previous = 0






