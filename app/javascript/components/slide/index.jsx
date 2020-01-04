import React from 'react';
import Swiper from 'react-id-swiper';
import Style from './style.sass';


export default class Slide extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      params: {
        slidesPerView: 1,
        spaceBetween: 30,
        loop: true,
        containerClass: Style.swiper__container,
        wrapperClass: Style.swiper__wrapper,
        slideClass: Style.swiper__slide,
        pagination: {
          el: 'Style.swiper__pagination',
          type: 'bullets',
          clickable: true
        },
        navigation: {
          nextEl: Style.swiper__next,
          prevEl: Style.swiper__prev, 
        },
        getSwiper: (swiper) => {
          swiper.on('slideChange', () => {
            console.log(`slide changed : ${swiper.activeIndex}`);
          })
        }
      }
    }
  }

  render() {
    return (
      <Swiper {...this.state.params}>
        { this.props.photos.map((photo, index) => 
          <img key={index} src={photo} />
        )}
      </Swiper>
    );
  }
}