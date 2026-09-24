import io

import cv2
import numpy as np


class ImageEnhancementService:

    def enhance(
        self,
        image_bytes: bytes
    ):

        image_array = cv2.imdecode(
            np.frombuffer(image_bytes, dtype=np.uint8),
            cv2.IMREAD_COLOR
        )

        if image_array is None:
            raise ValueError("Invalid image data")

        # --------------------------------
        # Resize
        # --------------------------------

        height, width = image_array.shape[:2]

        max_dimension = 1200

        if max(height, width) > max_dimension:

            scale = (
                max_dimension /
                max(height, width)
            )

            new_width = int(width * scale)
            new_height = int(height * scale)

            image_array = cv2.resize(
                image_array,
                (new_width, new_height),
                interpolation=cv2.INTER_AREA
            )

        # --------------------------------
        # Denoise
        # --------------------------------

        image_array = cv2.fastNlMeansDenoisingColored(
            image_array,
            None,
            5,
            5,
            7,
            21
        )

        # --------------------------------
        # Improve contrast
        # --------------------------------

        lab = cv2.cvtColor(
            image_array,
            cv2.COLOR_BGR2LAB
        )

        l, a, b = cv2.split(lab)

        clahe = cv2.createCLAHE(
            clipLimit=2.0,
            tileGridSize=(8, 8)
        )

        l = clahe.apply(l)

        enhanced = cv2.merge(
            [l, a, b]
        )

        enhanced = cv2.cvtColor(
            enhanced,
            cv2.COLOR_LAB2BGR
        )

        # --------------------------------
        # Encode
        # --------------------------------

        success, encoded = cv2.imencode(
            ".jpg",
            enhanced,
            [
                int(cv2.IMWRITE_JPEG_QUALITY),
                90
            ]
        )

        if not success:
            raise RuntimeError(
                "Image enhancement failed"
            )

        return encoded.tobytes()