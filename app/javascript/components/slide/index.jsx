import React from 'react';
import Swiper from 'swiper';

export default class extends React.component {
  constructor() {
    this.state = {
      slides: (function () {
        var slides = [];
        for (var i = 0; i < 600; i += 1) {
          slides.push('Slide' + (i + 1));
        }
        return slides;
      }()),
      virtualData: {
        slides: [],
      },
    }
  }
  componentDidMount() {
    const self = this;
    const swiper = new Swiper('.swiper-container', {
      virtual: {
        slides: self.state.slides,
        renderExternal(data) {
          self.setState({
            virtualData: data,
          });
        }
      },
    });
  }
  render() {
    <div className='swiper-container'>
      <div className='swiper-wrapper'>
        {this.state.virtualData.slides.map((slide, index) => (
          <div className='swiper-slide'
            key={index}
            style={{left: `${virtualData.offset}px`}}
            >{slide}</div>
        ))}
      </div>
    </div>
  }
}
