import time
import logging
from multiprocessing import Process, Lock, Value
from multiprocessing import log_to_stderr, get_logger

# Function fot adding 500 to total
def add_500(total, lock):
    for i in range(100):
        time.sleep(0.01)
        lock.acquire()
        total.value += 5
        lock.release()

# Function fot subtracting 500 to total
def sub_500(total, lock):
    for i in range(100):
        time.sleep(0.01)
        lock.acquire()
        total.value -= 5
        lock.release()

if __name__ == '__main__':

    total = Value('i', 500)
    lock = Lock()

    add_process = Process(target=add_500, args=(total, lock))
    sub_process = Process(target=sub_500, args=(total, lock))

    add_process.start()
    sub_process.start()

    add_process.join()
    sub_process.join()

    print(total.value)