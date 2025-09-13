import os

imgs = [f for f in os.listdir('gallery') if '' in f]

for img in imgs:
    print(f'<div class="swiper-slide"><img src="/gallery/{img}" alt="{img}"></div>')
