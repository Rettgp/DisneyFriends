//
//  DisneyMapOverlay.swift
//  DisneyFriends
//
//  Created by Garrett on 8/12/18.
//  Copyright © 2018 Garrett. All rights reserved.
//

import Foundation
import MapKit


class DisneyMapOverlay: MKTileOverlay
{
    override func url(forTilePath path: MKTileOverlayPath) -> URL
    {
        let tile_url = "https://cdn1.parksmedia.wdprapps.disney.com/media/maps/prod/\(path.z)/\(path.x)/\(path.y).jpg";
        return URL(string: tile_url)!
    }
}
