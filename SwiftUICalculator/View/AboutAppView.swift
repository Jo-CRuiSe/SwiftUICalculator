//
//  AboutAppView.swift
//  SwiftUICalculator
//
//  Created by Jo Cruise on 2024/6/7.
//

import SwiftUI

struct AboutAppView: View {
    var body: some View {
        VStack {
            AppIcon()
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Text(LocalizedStringKey("Calculator"))
        }   
        Text(
            """
            ds
            dsdsdsd
            sds
            """
        )
        
    }
}

#Preview {
    AboutAppView()
}

extension Bundle {
    var iconFileName: String? {
        guard let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
              let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
              let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
              let iconFileName = iconFiles.last
        else { return nil }
        return iconFileName
    }
}

struct AppIcon: View {
    var body: some View {
        Bundle.main.iconFileName
            .flatMap { UIImage(named: $0) }
            .map { Image(uiImage: $0) }
            
    }
}
